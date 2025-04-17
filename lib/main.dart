import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/data/providers/budget_provider.dart';
import 'package:finance_tracker/viewmodels/account_card_viewmodel.dart';
import 'package:finance_tracker/viewmodels/ad_service_viewmodel.dart';
import 'package:finance_tracker/viewmodels/asset_liability_viewmodel.dart';
import 'package:finance_tracker/viewmodels/auth_viewmodel.dart';
import 'package:finance_tracker/viewmodels/budget_viewmodel.dart';
import 'package:finance_tracker/viewmodels/savings_goal_viewmodel.dart';
import 'package:finance_tracker/viewmodels/settlement_viewmodel.dart';
import 'package:finance_tracker/viewmodels/theme_provider.dart';
import 'package:finance_tracker/viewmodels/transaction_viewmodel.dart';
import 'package:finance_tracker/viewmodels/projection_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/theme_constants.dart';
import 'core/routes/routes.dart';
import 'core/services/session_manager.dart';
import 'firebase_options.dart';
import 'presentation/views/session_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Enable Firestore offline persistence
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

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
        ChangeNotifierProvider(create: (_) => SessionManager(prefs: prefs)),
        ChangeNotifierProvider(create: (_) => TransactionViewModel()),
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
          ),
          update: (context, authVM, budgetVM) =>
              budgetVM ?? BudgetViewModel(authViewModel: authVM),
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
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Finance Tracker',
            theme: ThemeConstants.lightTheme,
            darkTheme: ThemeConstants.darkTheme,
            themeMode: themeProvider.themeMode,
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
