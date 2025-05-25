// lib/core/services/budget_notification_service.dart
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'dart:convert';
import '../../data/models/budget_model.dart';
import '../../data/models/app_notification_model.dart';
import 'notification_storeage_service.dart';

class BudgetNotificationService {
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NotificationStorageService _storageService =
      NotificationStorageService();

  // Threshold percentages for budget alerts
  static const double warningThreshold = 80.0; // 80%
  static const double criticalThreshold = 100.0; // 100%
  static const double overbudgetThreshold = 110.0; // 110%

  BudgetNotificationService() {
    tz_data.initializeTimeZones();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    try {
      const AndroidInitializationSettings androidInit =
          AndroidInitializationSettings('@mipmap/launcher_icon');

      const DarwinInitializationSettings iosInit = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const InitializationSettings initSettings = InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      );

      await _localNotifications.initialize(initSettings);

      // Create notification channels
      await _createNotificationChannels();
    } catch (e) {
      print('Error initializing budget notifications: $e');
    }
  }

  Future<void> _createNotificationChannels() async {
    const AndroidNotificationChannel budgetAlertsChannel =
        AndroidNotificationChannel(
      'budget_alerts',
      'Budget Alerts',
      description: 'Notifications for budget warnings and overspending alerts',
      importance: Importance.high,
      enableVibration: true,
      playSound: true,
    );

    const AndroidNotificationChannel budgetRemindersChannel =
        AndroidNotificationChannel(
      'budget_reminders',
      'Budget Reminders',
      description: 'Reminders about budget status and monthly summaries',
      importance: Importance.defaultImportance,
      enableVibration: true,
      playSound: true,
    );

    const AndroidNotificationChannel budgetReportsChannel =
        AndroidNotificationChannel(
      'budget_reports',
      'Budget Reports',
      description: 'Monthly budget performance reports',
      importance: Importance.defaultImportance,
      enableVibration: false,
      playSound: false,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(budgetAlertsChannel);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(budgetRemindersChannel);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(budgetReportsChannel);
  }

  // Check budget status and send appropriate notifications
  Future<void> checkBudgetStatus(
      BudgetModel budget, double currentSpent) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null || !budget.isActive) return;

      final spentPercentage =
          budget.amount > 0 ? (currentSpent / budget.amount) * 100 : 0;

      // Determine notification type based on spending percentage
      if (spentPercentage >= overbudgetThreshold) {
        await _sendOverbudgetAlert(
            budget, currentSpent, spentPercentage.toDouble());
      } else if (spentPercentage >= criticalThreshold) {
        await _sendCriticalBudgetAlert(
            budget, currentSpent, spentPercentage.toDouble());
      } else if (spentPercentage >= warningThreshold) {
        await _sendBudgetWarning(
            budget, currentSpent, spentPercentage.toDouble());
      }

      // Store budget status check in Firestore
      await _storeBudgetStatusCheck(
          budget, currentSpent, spentPercentage.toDouble());
    } catch (e) {
      print('Error checking budget status: $e');
    }
  }

  // Send warning when 80% of budget is reached
  Future<void> _sendBudgetWarning(
      BudgetModel budget, double currentSpent, double percentage) async {
    try {
      final notificationId =
          _generateBudgetNotificationId(budget.id, 'warning');
      final remaining = budget.amount - currentSpent;

      await _localNotifications.show(
        notificationId,
        '⚠️ Budget Warning',
        '${budget.category}: ${percentage.toStringAsFixed(1)}% used (${_formatCurrency(remaining)} remaining)',
        NotificationDetails(
          android: AndroidNotificationDetails(
            'budget_alerts',
            'Budget Alerts',
            channelDescription:
                'Notifications for budget warnings and overspending alerts',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/launcher_icon',
            color: const Color(0xFFFF9800), // Orange for warning
            styleInformation: BigTextStyleInformation(
              'You\'ve used ${percentage.toStringAsFixed(1)}% of your ${budget.category} budget (${_formatCurrency(currentSpent)} of ${_formatCurrency(budget.amount)}). You have ${_formatCurrency(remaining)} remaining.',
              contentTitle: '⚠️ Budget Warning - ${budget.category}',
            ),
            actions: [
              AndroidNotificationAction(
                'view_budget',
                'View Budget',
                icon: DrawableResourceAndroidBitmap('@drawable/ic_budget'),
              ),
              AndroidNotificationAction(
                'view_transactions',
                'View Expenses',
                icon:
                    DrawableResourceAndroidBitmap('@drawable/ic_transactions'),
              ),
            ],
          ),
          iOS: DarwinNotificationDetails(
            categoryIdentifier: 'BUDGET_WARNING',
            threadIdentifier: 'budget_${budget.id}',
            subtitle: 'Budget Alert',
          ),
        ),
        payload: jsonEncode({
          'type': 'budget_warning',
          'budgetId': budget.id,
          'category': budget.category,
          'screen': 'budget_details',
          'action': 'view_budget_warning'
        }),
      );

      // Store notification
      await _storeBudgetNotification(
        'Budget Warning',
        '${budget.category}: ${percentage.toStringAsFixed(1)}% used',
        'budget_warning',
        {
          'budgetId': budget.id,
          'category': budget.category,
          'percentage': percentage,
          'currentSpent': currentSpent,
          'budgetAmount': budget.amount,
        },
      );
    } catch (e) {
      print('Error sending budget warning: $e');
    }
  }

  // Send critical alert when 100% of budget is reached
  Future<void> _sendCriticalBudgetAlert(
      BudgetModel budget, double currentSpent, double percentage) async {
    try {
      final notificationId =
          _generateBudgetNotificationId(budget.id, 'critical');

      await _localNotifications.show(
        notificationId,
        '🚨 Budget Limit Reached',
        '${budget.category}: Budget fully used (${_formatCurrency(currentSpent)})',
        NotificationDetails(
          android: AndroidNotificationDetails(
            'budget_alerts',
            'Budget Alerts',
            channelDescription:
                'Notifications for budget warnings and overspending alerts',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@mipmap/launcher_icon',
            color: const Color(0xFFF44336), // Red for critical
            styleInformation: BigTextStyleInformation(
              'You\'ve reached your ${budget.category} budget limit! You\'ve spent ${_formatCurrency(currentSpent)} of your ${_formatCurrency(budget.amount)} budget. Consider reviewing your expenses.',
              contentTitle: '🚨 Budget Limit Reached - ${budget.category}',
            ),
            actions: [
              AndroidNotificationAction(
                'review_budget',
                'Review Budget',
                icon: DrawableResourceAndroidBitmap('@drawable/ic_review'),
              ),
              AndroidNotificationAction(
                'adjust_budget',
                'Adjust Budget',
                icon: DrawableResourceAndroidBitmap('@drawable/ic_edit'),
              ),
            ],
          ),
          iOS: DarwinNotificationDetails(
            categoryIdentifier: 'BUDGET_CRITICAL',
            threadIdentifier: 'budget_${budget.id}',
            subtitle: 'Critical Alert',
          ),
        ),
        payload: jsonEncode({
          'type': 'budget_critical',
          'budgetId': budget.id,
          'category': budget.category,
          'screen': 'budget_details',
          'action': 'view_budget_critical'
        }),
      );

      // Store notification
      await _storeBudgetNotification(
        'Budget Limit Reached',
        '${budget.category}: Budget fully used',
        'budget_critical',
        {
          'budgetId': budget.id,
          'category': budget.category,
          'percentage': percentage,
          'currentSpent': currentSpent,
          'budgetAmount': budget.amount,
        },
      );
    } catch (e) {
      print('Error sending critical budget alert: $e');
    }
  }

  // Send overspending alert when budget is exceeded
  Future<void> _sendOverbudgetAlert(
      BudgetModel budget, double currentSpent, double percentage) async {
    try {
      final notificationId =
          _generateBudgetNotificationId(budget.id, 'overbudget');
      final overspent = currentSpent - budget.amount;

      await _localNotifications.show(
        notificationId,
        '💸 Budget Exceeded',
        '${budget.category}: ${_formatCurrency(overspent)} over budget!',
        NotificationDetails(
          android: AndroidNotificationDetails(
            'budget_alerts',
            'Budget Alerts',
            channelDescription:
                'Notifications for budget warnings and overspending alerts',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@mipmap/launcher_icon',
            color: const Color(0xFFD32F2F), // Dark red for overspending
            styleInformation: BigTextStyleInformation(
              'OVERSPENDING ALERT! You\'ve exceeded your ${budget.category} budget by ${_formatCurrency(overspent)}. Total spent: ${_formatCurrency(currentSpent)} (Budget: ${_formatCurrency(budget.amount)}). Take immediate action to control spending.',
              contentTitle: '💸 Budget Exceeded - ${budget.category}',
            ),
            actions: [
              AndroidNotificationAction(
                'emergency_review',
                'Emergency Review',
                icon: DrawableResourceAndroidBitmap('@drawable/ic_emergency'),
              ),
              AndroidNotificationAction(
                'stop_spending',
                'Spending Freeze',
                icon: DrawableResourceAndroidBitmap('@drawable/ic_freeze'),
              ),
            ],
          ),
          iOS: DarwinNotificationDetails(
            categoryIdentifier: 'BUDGET_EXCEEDED',
            threadIdentifier: 'budget_${budget.id}',
            subtitle: 'Overspending Alert',
          ),
        ),
        payload: jsonEncode({
          'type': 'budget_exceeded',
          'budgetId': budget.id,
          'category': budget.category,
          'overspent': overspent,
          'screen': 'budget_details',
          'action': 'view_budget_exceeded'
        }),
      );

      // Store notification
      await _storeBudgetNotification(
        'Budget Exceeded',
        '${budget.category}: ${_formatCurrency(overspent)} over budget',
        'budget_exceeded',
        {
          'budgetId': budget.id,
          'category': budget.category,
          'percentage': percentage,
          'currentSpent': currentSpent,
          'budgetAmount': budget.amount,
          'overspent': overspent,
        },
      );
    } catch (e) {
      print('Error sending overbudget alert: $e');
    }
  }

  // Schedule monthly budget summary notification
  Future<void> scheduleMonthlyBudgetSummary(List<BudgetModel> budgets) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return;

      // Schedule for the last day of the month at 6 PM
      final now = DateTime.now();
      final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
      final summaryTime = DateTime(
        lastDayOfMonth.year,
        lastDayOfMonth.month,
        lastDayOfMonth.day,
        18, // 6 PM
        0,
      );

      // Only schedule if the date is in the future
      if (summaryTime.isAfter(DateTime.now())) {
        final notificationId = _generateBudgetNotificationId(
            'monthly_summary', now.month.toString());

        await _localNotifications.zonedSchedule(
          notificationId,
          '📊 Monthly Budget Summary',
          'Your budget performance summary for ${_getMonthName(now.month)} is ready',
          tz.TZDateTime.from(summaryTime, tz.local),
          NotificationDetails(
            android: AndroidNotificationDetails(
              'budget_reports',
              'Budget Reports',
              channelDescription: 'Monthly budget performance reports',
              importance: Importance.defaultImportance,
              priority: Priority.defaultPriority,
              icon: '@mipmap/launcher_icon',
              color: const Color(0xFF2196F3), // Blue for reports
              styleInformation: const BigTextStyleInformation(
                'Review your monthly budget performance and get insights for better financial planning.',
                contentTitle: '📊 Monthly Budget Summary',
              ),
            ),
            iOS: DarwinNotificationDetails(
              categoryIdentifier: 'BUDGET_SUMMARY',
              threadIdentifier: 'budget_summary_${now.month}',
              subtitle: 'Monthly Report',
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: jsonEncode({
            'type': 'monthly_budget_summary',
            'month': now.month,
            'year': now.year,
            'screen': 'budget_summary',
            'action': 'view_monthly_summary'
          }),
        );
      }
    } catch (e) {
      print('Error scheduling monthly budget summary: $e');
    }
  }

  // Send immediate notification when budget is created or updated
  Future<void> sendBudgetUpdateNotification(
      BudgetModel budget, String action) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return;

      String title;
      String body;
      String type;

      switch (action.toLowerCase()) {
        case 'created':
          title = '✅ Budget Created';
          body =
              'New budget for ${budget.category}: ${_formatCurrency(budget.amount)}';
          type = 'budget_created';
          break;
        case 'updated':
          title = '📝 Budget Updated';
          body = 'Budget for ${budget.category} has been updated';
          type = 'budget_updated';
          break;
        case 'deleted':
          title = '🗑️ Budget Deleted';
          body = 'Budget for ${budget.category} has been removed';
          type = 'budget_deleted';
          break;
        default:
          return;
      }

      const notificationId =
          888888; // Unique ID for immediate budget notifications

      await _localNotifications.show(
        notificationId,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'budget_reminders',
            'Budget Reminders',
            channelDescription:
                'Reminders about budget status and monthly summaries',
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
            icon: '@mipmap/launcher_icon',
            color: const Color(0xFF4CAF50), // Green for updates
          ),
          iOS: DarwinNotificationDetails(
            categoryIdentifier: 'BUDGET_UPDATE',
            threadIdentifier: 'budget_update_${budget.id}',
            subtitle: 'Budget Update',
          ),
        ),
        payload: jsonEncode({
          'type': type,
          'budgetId': budget.id,
          'category': budget.category,
          'screen': 'budget_details',
          'action': 'view_budget_update'
        }),
      );

      // Store notification
      await _storeBudgetNotification(
        title.replaceAll(RegExp(r'[^\w\s]'), ''), // Remove emojis for storage
        body,
        type,
        {
          'budgetId': budget.id,
          'category': budget.category,
          'budgetAmount': budget.amount,
          'action': action,
        },
      );
    } catch (e) {
      print('Error sending budget update notification: $e');
    }
  }

  // Send weekly budget check-in notification
  Future<void> scheduleWeeklyBudgetCheckIn() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return;

      // Schedule for every Sunday at 7 PM
      final now = DateTime.now();
      final daysUntilSunday = 7 - now.weekday;
      final nextSunday = now.add(Duration(days: daysUntilSunday));
      final checkInTime = DateTime(
        nextSunday.year,
        nextSunday.month,
        nextSunday.day,
        19, // 7 PM
        0,
      );

      const notificationId = 777777;

      await _localNotifications.zonedSchedule(
        notificationId,
        '📈 Weekly Budget Check-in',
        'How are your budgets doing this week?',
        tz.TZDateTime.from(checkInTime, tz.local),
        NotificationDetails(
          android: AndroidNotificationDetails(
            'budget_reminders',
            'Budget Reminders',
            channelDescription:
                'Reminders about budget status and monthly summaries',
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
            icon: '@mipmap/launcher_icon',
            color: const Color(0xFF9C27B0), // Purple for check-ins
            styleInformation: const BigTextStyleInformation(
              'Take a moment to review your spending this week and stay on track with your financial goals.',
              contentTitle: '📈 Weekly Budget Check-in',
            ),
          ),
          iOS: DarwinNotificationDetails(
            categoryIdentifier: 'BUDGET_CHECKIN',
            threadIdentifier: 'budget_weekly_checkin',
            subtitle: 'Weekly Review',
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: jsonEncode({
          'type': 'weekly_budget_checkin',
          'screen': 'budget_overview',
          'action': 'weekly_review'
        }),
      );
    } catch (e) {
      print('Error scheduling weekly budget check-in: $e');
    }
  }

  // Helper methods
  Future<void> _storeBudgetStatusCheck(
      BudgetModel budget, double currentSpent, double percentage) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return;

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('budget_status_checks')
          .add({
        'budgetId': budget.id,
        'category': budget.category,
        'budgetAmount': budget.amount,
        'currentSpent': currentSpent,
        'percentage': percentage,
        'timestamp': FieldValue.serverTimestamp(),
        'status': percentage >= overbudgetThreshold
            ? 'exceeded'
            : percentage >= criticalThreshold
                ? 'critical'
                : percentage >= warningThreshold
                    ? 'warning'
                    : 'normal',
      });
    } catch (e) {
      print('Error storing budget status check: $e');
    }
  }

  Future<void> _storeBudgetNotification(
    String title,
    String body,
    String type,
    Map<String, dynamic> data,
  ) async {
    try {
      final notification = AppNotification(
        id: '',
        title: title,
        body: body,
        type: type,
        isRead: false,
        timestamp: DateTime.now(),
        data: data,
      );

      await _storageService.storeNotification(notification);
    } catch (e) {
      print('Error storing budget notification: $e');
    }
  }

  int _generateBudgetNotificationId(String budgetId, String type) {
    final combined = 'budget_${budgetId}_$type';
    return combined.hashCode.abs() % 2147483647; // Ensure positive int32
  }

  String _formatCurrency(double amount) {
    return '₹${amount.toStringAsFixed(2)}';
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  // Cancel all budget notifications for a specific budget
  Future<void> cancelBudgetNotifications(String budgetId) async {
    try {
      final warningNotificationId =
          _generateBudgetNotificationId(budgetId, 'warning');
      final criticalNotificationId =
          _generateBudgetNotificationId(budgetId, 'critical');
      final overbudgetNotificationId =
          _generateBudgetNotificationId(budgetId, 'overbudget');

      await _localNotifications.cancel(warningNotificationId);
      await _localNotifications.cancel(criticalNotificationId);
      await _localNotifications.cancel(overbudgetNotificationId);
    } catch (e) {
      print('Error cancelling budget notifications: $e');
    }
  }

  // Get pending budget notifications
  Future<List<Map<String, dynamic>>> getPendingBudgetNotifications() async {
    final pending = await _localNotifications.pendingNotificationRequests();
    return pending
        .where((request) => request.payload?.contains('budget') ?? false)
        .map((request) => {
              'id': request.id,
              'title': request.title,
              'body': request.body,
              'payload': request.payload,
            })
        .toList();
  }

  // Cancel all budget notifications
  Future<void> cancelAllBudgetNotifications() async {
    try {
      final pending = await _localNotifications.pendingNotificationRequests();
      for (final request in pending) {
        if (request.payload?.contains('budget') ?? false) {
          await _localNotifications.cancel(request.id);
        }
      }
    } catch (e) {
      print('Error cancelling all budget notifications: $e');
    }
  }

  // Send push notification via FCM
  Future<void> _sendBudgetPushNotification(
    String title,
    String body,
    String type,
    Map<String, dynamic> data,
  ) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return;

      final fcmToken = await _messaging.getToken();
      if (fcmToken == null) {
        print('FCM token not available');
        return;
      }

      await _firestore.collection('notification_queue').add({
        'userId': userId,
        'fcmToken': fcmToken,
        'type': type,
        'title': title,
        'body': body,
        'data': data,
        'timestamp': FieldValue.serverTimestamp(),
        'processed': false,
      });
    } catch (e) {
      print('Error sending budget push notification: $e');
    }
  }
}
