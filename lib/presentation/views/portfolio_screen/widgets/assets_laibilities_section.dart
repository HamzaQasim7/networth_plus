import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../../../viewmodels/asset_liability_viewmodel.dart';
import '../../../../data/models/asset_liability_model.dart';

class AssetsLiabilitiesSection extends StatefulWidget {
  const AssetsLiabilitiesSection({super.key});

  @override
  AssetsLiabilitiesSectionState createState() => AssetsLiabilitiesSectionState();
}

class AssetsLiabilitiesSectionState extends State<AssetsLiabilitiesSection> {
  int _selectedTabIndex = 0;

  // Public getter for _selectedTabIndex
  int get selectedTabIndex => _selectedTabIndex;

  @override
  void initState() {
    super.initState();
    // Initialize data loading
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<AssetLiabilityViewModel>(
        context, 
        listen: false
      );
      if (viewModel.items.isEmpty) {
        viewModel.loadAssetLiabilities();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AssetLiabilityViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.error != null) {
          return Text('Error: ${viewModel.error}');
        }

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
            _selectedTabIndex == 0 ? _buildAssetsList(viewModel.assets) : _buildLiabilitiesList(viewModel.liabilities),
          ],
        );
      },
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

  Widget _buildAssetsList(List<AssetLiabilityModel> assets) {
    return Column(
      children: assets.map((asset) => _buildListItem(asset)).toList(),
    );
  }

  Widget _buildLiabilitiesList(List<AssetLiabilityModel> liabilities) {
    return Column(
      children: liabilities.map((liability) => _buildListItem(liability)).toList(),
    );
  }

  Widget _buildListItem(AssetLiabilityModel item) {
    return Builder(builder: (context) {
      final viewModel = Provider.of<AssetLiabilityViewModel>(context, listen: false);
      final isDarkMode = Theme.of(context).brightness == Brightness.dark;

      return Dismissible(
        key: Key(item.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          color: Colors.red,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Delete Item'),
              content: const Text('Are you sure you want to delete this item?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
        },
        onDismissed: (direction) {
          viewModel.deleteAssetLiability(item.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Deleted ${item.name}'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  viewModel.createAssetLiability(item);
                },
              ),
            ),
          );
        },
        child: Container(
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
                child: Icon(Icons.account_balance_wallet_outlined,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                item.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isDarkMode
                          ? ThemeConstants.textPrimaryDark
                          : ThemeConstants.textPrimaryLight,
                    ),
              ),
              const Spacer(),
              Text(
                '₹${item.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: _selectedTabIndex == 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
