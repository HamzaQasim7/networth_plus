import 'package:finance_tracker/core/routes/routes.dart';
import 'package:finance_tracker/core/services/session_manager.dart';
import 'package:finance_tracker/presentation/views/settings/widgets/notification_toggle.dart';
import 'package:finance_tracker/viewmodels/auth_viewmodel.dart';
import 'package:finance_tracker/viewmodels/theme_provider.dart';
import 'package:finance_tracker/widgets/shared_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/settings_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: const SharedAppbar(title: 'Settings'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: Column(
            children: [
              _buildProfileSection(context),
              const SizedBox(height: 24),
              _buildSupportSection(context),
              const SizedBox(height: 16),
              _SettingsSection(
                title: 'Reports & Analytics',
                children: [
                  SettingsTile(
                    title: 'Future Projections',
                    subtitle: 'View financial forecasts and trends',
                    leading: _buildIconContainer(context, Icons.trending_up),
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Past Performance',
                    subtitle: 'Historical financial analysis',
                    leading: _buildIconContainer(context, Icons.history),
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Income & Expense Analysis',
                    subtitle: 'Compare income, expenses and savings',
                    leading: _buildIconContainer(context, Icons.analytics),
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Budget vs Actual',
                    subtitle: 'Track budget performance',
                    leading: _buildIconContainer(context, Icons.compare_arrows),
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Download Reports',
                    subtitle: 'Export financial reports',
                    leading: _buildIconContainer(context, Icons.download),
                    onTap: () {},
                  ),
                ],
              ),
              _SettingsSection(
                title: 'App Preferences',
                children: [
                  SettingsTile(
                    title: 'Currency',
                    subtitle: 'Set your preferred currency',
                    leading:
                        _buildIconContainer(context, Icons.currency_exchange),
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'App Theme',
                    subtitle: isDarkMode ? 'Dark Mode' : 'Light Mode',
                    leading: _buildIconContainer(
                        context,
                        isDarkMode
                            ? Icons.nights_stay_outlined
                            : Icons.wb_sunny_outlined),
                    trailing: Switch(
                      value: isDarkMode,
                      activeColor: Theme.of(context).colorScheme.primary,
                      onChanged: (_) => themeProvider.toggleTheme(),
                    ),
                  ),
                  SettingsTile(
                    title: 'Language',
                    subtitle: 'Choose your preferred language',
                    leading: _buildIconContainer(context, Icons.language),
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Theme Customization',
                    subtitle: 'Customize app appearance',
                    leading:
                        _buildIconContainer(context, Icons.palette_outlined),
                    onTap: () {},
                  ),
                ],
              ),
              _SettingsSection(
                title: 'Notifications',
                children: [
                  SettingsTile(
                    title: 'Budget Limits',
                    subtitle: 'Get alerts when nearing budget limits',
                    leading: _buildIconContainer(context, Icons.warning_amber),
                    trailing: const NotificationToggle(),
                  ),
                  SettingsTile(
                    title: 'Bill Payment Reminders',
                    subtitle: 'Never miss a payment deadline',
                    leading: _buildIconContainer(context, Icons.calendar_today),
                    trailing: const NotificationToggle(),
                  ),
                ],
              ),
              _SettingsSection(
                title: 'Planning & Financial Goals',
                children: [
                  SettingsTile(
                    title: 'Savings Goals',
                    subtitle: 'Set and track savings targets',
                    leading: _buildIconContainer(context, Icons.savings),
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Debt Repayment Plan',
                    subtitle: 'Manage and track debt payments',
                    leading:
                        _buildIconContainer(context, Icons.account_balance),
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Retirement Planning',
                    subtitle: 'Plan for your retirement',
                    leading: _buildIconContainer(context, Icons.beach_access),
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Financial Calculator',
                    subtitle: 'Calculate loans, investments & more',
                    leading: _buildIconContainer(context, Icons.calculate),
                    onTap: () {},
                  ),
                ],
              ),
              _SettingsSection(
                title: 'Account Settings',
                children: [
                  SettingsTile(
                    title: 'Profile',
                    subtitle: 'Manage personal information',
                    leading: _buildIconContainer(context, Icons.person_outline),
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Subscription Plan',
                    subtitle: 'Manage your subscription',
                    leading:
                        _buildIconContainer(context, Icons.card_membership),
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Security',
                    subtitle: 'App lock, biometrics & backup',
                    leading: _buildIconContainer(context, Icons.security),
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Data Backup & Sync',
                    subtitle: 'Manage your data across devices',
                    leading: _buildIconContainer(context, Icons.sync),
                    onTap: () {},
                  ),
                ],
              ),
              _SettingsSection(
                title: 'More',
                children: [
                  SettingsTile(
                    title: 'Help & Support',
                    subtitle: 'FAQ, Contact & Support',
                    leading: _buildIconContainer(context, Icons.help_outline),
                    onTap: () => _showHelpSupportDialog(context),
                  ),
                  SettingsTile(
                    title: 'Terms & Privacy',
                    subtitle: 'Terms of Service, Privacy Policy',
                    leading: _buildIconContainer(
                        context, Icons.privacy_tip_outlined),
                    onTap: () => _showTermsPrivacyDialog(context),
                  ),
                  SettingsTile(
                    title: 'About App',
                    subtitle: 'Version 1.0.0',
                    leading: _buildIconContainer(context, Icons.info_outline),
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'Finance Tracker',
                        applicationVersion: '1.0.0',
                        applicationIcon: const FlutterLogo(size: 32),
                        children: const [
                          Text(
                            'A comprehensive finance tracking application to manage your expenses, budgets, and financial portfolio.',
                          ),
                        ],
                      );
                    },
                  ),
                  SettingsTile(
                    title: 'Sign Out',
                    textColor: Colors.red,
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.logout_outlined,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () => _handleSignOut(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportSection(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Support the App',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_outline),
                        label: const Text('Donate'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.play_circle_outline),
                        label: const Text('Watch Ad'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconContainer(BuildContext context, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Future<void> _handleSignOut(BuildContext context) async {
    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Sign Out',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );

    if (shouldLogout != true || !context.mounted) return;

    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Get providers
      final sessionManager = context.read<SessionManager>();
      final authViewModel = context.read<AuthViewModel>();

      // Sign out from both
      await Future.wait([
        sessionManager.signOut(),
        authViewModel.signOut(),
      ]);

      if (context.mounted) {
        // Close loading dialog
        Navigator.pop(context);

        // Navigate to login and clear stack
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.signIn,
          (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        // Close loading dialog if it's showing
        Navigator.maybeOf(context)?.pop();

        // Show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error signing out: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Widget _buildProfileSection(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, userProvider, _) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              userProvider.currentUser?.name ?? 'User',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              userProvider.currentUser?.email ?? 'user@gmail.com',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[400]
                        : Colors.grey[600],
                  ),
            ),
          ],
        ),
      );
    });
  }

  void _showHelpSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHelpSection(
                'Frequently Asked Questions',
                Icons.question_answer_outlined,
                () {
                  Navigator.pop(context);
                  // Navigate to FAQ page
                },
              ),
              const Divider(),
              _buildHelpSection(
                'Contact Support',
                Icons.email_outlined,
                () {
                  // Launch email client
                  // You can use url_launcher package to implement this
                  // launchUrl(Uri.parse('mailto:support@yourapp.com'));
                },
              ),
              const Divider(),
              _buildHelpSection(
                'Live Chat Support',
                Icons.chat_outlined,
                () {
                  Navigator.pop(context);
                  // Navigate to chat support
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpSection(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  void _showTermsPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms & Privacy'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHelpSection(
                'Terms of Service',
                Icons.description_outlined,
                () {
                  Navigator.pop(context);
                  // Navigate to Terms of Service page or open URL
                },
              ),
              const Divider(),
              _buildHelpSection(
                'Privacy Policy',
                Icons.privacy_tip_outlined,
                () {
                  Navigator.pop(context);
                  // Navigate to Privacy Policy page or open URL
                },
              ),
              const Divider(),
              _buildHelpSection(
                'Data Usage',
                Icons.data_usage_outlined,
                () {
                  Navigator.pop(context);
                  // Navigate to Data Usage page
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
        ),
        ...children,
        const SizedBox(height: 16),
      ],
    );
  }
}
