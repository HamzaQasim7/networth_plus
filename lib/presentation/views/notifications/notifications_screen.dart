import 'package:finance_tracker/core/constants/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: ThemeConstants.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: 'Mark all as read',
            onPressed: () {
              // Mark all notifications as read
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All notifications marked as read'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Unread'),
          ],
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationsList(allNotifications),
          _buildNotificationsList(
              allNotifications.where((n) => !n['isRead']).toList()),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(List<Map<String, dynamic>> notifications) {
    if (notifications.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_off_outlined,
                size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No notifications',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationItem(notification);
      },
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    final isRead = notification['isRead'] as bool;
    final category = notification['category'] as String;

    IconData getIconForCategory(String category) {
      switch (category) {
        case 'transaction':
          return Icons.account_balance_wallet_outlined;
        case 'budget':
          return Icons.money;
        case 'asset':
          return Icons.arrow_upward;
        case 'liability':
          return Icons.arrow_downward;
        case 'alert':
          return Icons.warning_amber_outlined;
        default:
          return Icons.notifications_outlined;
      }
    }

    Color getColorForCategory(String category) {
      switch (category) {
        case 'transaction':
          return Colors.blue;
        case 'budget':
          return Colors.orange;
        case 'asset':
          return Colors.green;
        case 'liability':
          return Colors.red;
        case 'alert':
          return Colors.amber;
        default:
          return Colors.grey;
      }
    }

    return Dismissible(
      key: Key(notification['id']),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // Remove notification logic would go here
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notification removed'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isRead ? null : Colors.blue.shade50,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: getColorForCategory(category).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              getIconForCategory(category),
              color: getColorForCategory(category),
            ),
          ),
          title: Text(
            notification['title'],
            style: TextStyle(
              fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(notification['message']),
              const SizedBox(height: 4),
              Text(
                notification['time'],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          isThreeLine: true,
          onTap: () {
            // Mark as read and navigate to relevant screen
            setState(() {
              notification['isRead'] = true;
            });

            // Navigation logic based on notification type would go here
          },
          trailing: isRead
              ? null
              : Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
        ),
      ),
    );
  }
}

// Sample notification data
final List<Map<String, dynamic>> allNotifications = [
  {
    'id': '1',
    'title': 'Budget Alert',
    'message': 'You\'ve reached 80% of your Food budget for this month.',
    'time': '10 minutes ago',
    'isRead': false,
    'category': 'budget',
  },
  {
    'id': '2',
    'title': 'New Transaction',
    'message': 'Payment of ₹2,500 to Amazon has been recorded.',
    'time': '2 hours ago',
    'isRead': false,
    'category': 'transaction',
  },
  {
    'id': '3',
    'title': 'Bill Reminder',
    'message': 'Your electricity bill of ₹1,200 is due tomorrow.',
    'time': 'Yesterday',
    'isRead': true,
    'category': 'alert',
  },
  {
    'id': '4',
    'title': 'Asset Update',
    'message': 'Your investment portfolio has increased by 2.5%.',
    'time': '2 days ago',
    'isRead': true,
    'category': 'asset',
  },
  {
    'id': '5',
    'title': 'Loan Payment',
    'message': 'Your home loan EMI of ₹15,000 has been paid.',
    'time': '3 days ago',
    'isRead': true,
    'category': 'liability',
  },
  {
    'id': '6',
    'title': 'Budget Exceeded',
    'message': 'You\'ve exceeded your Shopping budget by ₹1,500.',
    'time': '5 days ago',
    'isRead': true,
    'category': 'budget',
  },
];
