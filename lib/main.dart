import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/data/providers/budget_provider.dart';
import 'package:finance_tracker/viewmodels/account_card_viewmodel.dart';
import 'package:finance_tracker/viewmodels/ad_service_viewmodel.dart';
import 'package:finance_tracker/viewmodels/asset_liability_viewmodel.dart';
import 'package:finance_tracker/viewmodels/auth_viewmodel.dart';
import 'package:finance_tracker/viewmodels/budget_viewmodel.dart';
import 'package:finance_tracker/viewmodels/debt_viewmodel.dart';
import 'package:finance_tracker/viewmodels/locale_view_model.dart';
import 'package:finance_tracker/viewmodels/profile_viewmodel.dart';
import 'package:finance_tracker/viewmodels/projection_viewmodel.dart';
import 'package:finance_tracker/viewmodels/retirement_viewmodel.dart';
import 'package:finance_tracker/viewmodels/savings_goal_viewmodel.dart';
import 'package:finance_tracker/viewmodels/settlement_viewmodel.dart';
import 'package:finance_tracker/viewmodels/subscription_viewmodel.dart';
import 'package:finance_tracker/viewmodels/theme_provider.dart';
import 'package:finance_tracker/viewmodels/transaction_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/theme_constants.dart';
import 'core/routes/routes.dart';
import 'core/services/localization_service.dart';
import 'core/services/notification_service.dart';
import 'core/services/session_manager.dart';
import 'firebase_options.dart';
import 'presentation/views/session_wrapper.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Restrict the app to portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Enable Firestore offline persistence
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // Initialize notification service
  final notificationService = NotificationService();
  await notificationService.initialize();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SessionManager>(
          create: (_) => SessionManager(prefs: prefs),
        ),
        ChangeNotifierProvider(
          create: (_) => AdViewModel()
            ..loadBannerAd()
            ..loadInterstitialAd(),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => LocaleViewModel()),
        ChangeNotifierProvider(create: (_) => SessionManager(prefs: prefs)),
        ChangeNotifierProvider(
            create: (_) =>
                TransactionViewModel(authViewModel: AuthViewModel())),
        ChangeNotifierProxyProvider<AuthViewModel, AssetLiabilityViewModel>(
          create: (context) => AssetLiabilityViewModel(
            authViewModel: context.read<AuthViewModel>(),
          ),
          update: (context, auth, previous) => AssetLiabilityViewModel(
            authViewModel: auth,
            repository: previous?.repository,
          ),
        ),
        ChangeNotifierProvider(create: (_) => BudgetProvider()),
        ChangeNotifierProxyProvider<AuthViewModel, BudgetViewModel>(
          create: (context) => BudgetViewModel(
            authViewModel: context.read<AuthViewModel>(),
            transactionViewModel: context.read<TransactionViewModel>(),
          ),
          update: (context, authVM, budgetVM) =>
              budgetVM ??
              BudgetViewModel(
                authViewModel: authVM,
                transactionViewModel: context.read<TransactionViewModel>(),
              ),
        ),
        ChangeNotifierProxyProvider<AuthViewModel, SettlementViewModel>(
          create: (context) => SettlementViewModel(
            authViewModel: Provider.of<AuthViewModel>(context, listen: false),
          ),
          update: (context, authViewModel, settlementViewModel) =>
              SettlementViewModel(
            authViewModel: authViewModel,
          ),
        ),
        ChangeNotifierProxyProvider<AuthViewModel, AccountCardViewModel>(
          create: (context) => AccountCardViewModel(
            authViewModel: context.read<AuthViewModel>(),
          ),
          update: (context, auth, previous) => AccountCardViewModel(
            authViewModel: auth,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ProjectionViewModel(
            transactionVM: context.read<TransactionViewModel>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SavingsGoalViewModel(
            authViewModel: context.read<AuthViewModel>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DebtViewModel(
            authViewModel: context.read<AuthViewModel>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RetirementViewModel(
            authViewModel: context.read<AuthViewModel>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileViewModel(
            authViewModel: context.read<AuthViewModel>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SubscriptionViewModel(
            authViewModel: context.read<AuthViewModel>(),
          ),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          final localeViewModel = Provider.of<LocaleViewModel>(context);
          // If still loading, show loading indicator
          if (localeViewModel.isLoading) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          Locale appLocale;
          if (localeViewModel.isSystemDefault) {
            // Use the system locale, but ensure it's a supported one
            appLocale = LocalizationService.supportedLocales.firstWhere(
              (locale) =>
                  locale.languageCode ==
                  WidgetsBinding.instance.window.locale.languageCode,
              orElse: () => const Locale('en', ''),
            );
          } else {
            // Use the selected locale
            appLocale = localeViewModel.locale!;
          }
          return MaterialApp(
            title: 'NetWorth+',
            theme: ThemeConstants.lightTheme,
            darkTheme: ThemeConstants.darkTheme,
            themeMode: themeProvider.themeMode,
            locale: appLocale,
            supportedLocales: LocalizationService.supportedLocales,
            localizationsDelegates: LocalizationService.localizationDelegates,
            home: const SessionWrapper(),
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.sessionWrapper,
            onGenerateRoute: RouteGenerator.getRoute,
          );
        },
      ),
    );
  }
}
