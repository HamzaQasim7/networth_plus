import 'package:flutter/material.dart';

import '../../../../core/constants/theme_constants.dart';

class AssetsLiabilitiesSection extends StatefulWidget {
  const AssetsLiabilitiesSection({super.key});

  @override
  AssetsLiabilitiesSectionState createState() => AssetsLiabilitiesSectionState();
}

class AssetsLiabilitiesSectionState extends State<AssetsLiabilitiesSection> {
  int _selectedTabIndex = 0;

  // Public getter for _selectedTabIndex
  int get selectedTabIndex => _selectedTabIndex;

  final List<Map<String, dynamic>> _assets = [
    {'name': 'House', 'amount': 1000000.00},
    {'name': 'Stocks', 'amount': 25000.00},
    {'name': 'Car', 'amount': 500000.00},
    {'name': 'Cash & Bank', 'amount': 100000.00},
  ];

  final List<Map<String, dynamic>> _liabilities = [
    {'name': 'Home Loan', 'amount': 800000.00},
    {'name': 'Car Loan', 'amount': 300000.00},
    {'name': 'Personal Loan', 'amount': 50000.00},
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab buttons
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTab('Assets', 0),
              _buildTab('Liabilities', 1),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // List content
        _selectedTabIndex == 0 ? _buildAssetsList() : _buildLiabilitiesList(),
      ],
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = _selectedTabIndex == index;

    return Builder(builder: (context) {
      final isDarkMode = Theme.of(context).brightness == Brightness.dark;

      return Expanded(
        child: GestureDetector(
          onTap: () => setState(() => _selectedTabIndex = index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? isDarkMode
                      ? ThemeConstants.cardDark
                      : Colors.white
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(100),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: isDarkMode
                            ? Colors.black.withOpacity(0.3)
                            : Colors.grey.shade300,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ]
                  : null,
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isSelected
                        ? isDarkMode
                            ? ThemeConstants.textPrimaryDark
                            : Colors.black87
                        : isDarkMode
                            ? Colors.grey.shade400
                            : Colors.grey,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildAssetsList() {
    return Column(
      children: _assets
          .map((asset) => _buildListItem(
                asset['name'],
                asset['amount'],
                Icons.account_balance_wallet_outlined,
              ))
          .toList(),
    );
  }

  Widget _buildLiabilitiesList() {
    return Column(
      children: _liabilities
          .map((liability) => _buildListItem(
                liability['name'],
                liability['amount'],
                Icons.account_balance_wallet_outlined,
              ))
          .toList(),
    );
  }

  Widget _buildListItem(String title, double amount, IconData icon) {
    return Builder(builder: (context) {
      final isDarkMode = Theme.of(context).brightness == Brightness.dark;

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isDarkMode
                        ? ThemeConstants.textPrimaryDark
                        : ThemeConstants.textPrimaryLight,
                  ),
            ),
            const Spacer(),
            Text(
              '₹${amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: _selectedTabIndex == 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      );
    });
  }
}
