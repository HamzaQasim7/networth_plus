import 'package:finance_tracker/core/constants/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../viewmodels/dashboard_viewmodel.dart';

class ActivitySearchScreen extends StatefulWidget {
  const ActivitySearchScreen({super.key});

  @override
  State<ActivitySearchScreen> createState() => _ActivitySearchScreenState();
}

class _ActivitySearchScreenState extends State<ActivitySearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredTransactions = [];

  @override
  void initState() {
    super.initState();
    // Load transactions from ViewModel
    // final vm = Provider.of<DashboardViewModel>(context, listen: false);
    // _filteredTransactions = vm.transactions;
  }

  void _searchTransactions(String query) {
    final vm = Provider.of<DashboardViewModel>(context, listen: false);
    setState(() {
      // _filteredTransactions = vm.transactions.where((transaction) {
      //   return transaction.title.toLowerCase().contains(query.toLowerCase()) ||
      //          transaction.category.toLowerCase().contains(query.toLowerCase()) ||
      //          transaction.amount.toString().contains(query);
      // }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 20, color: ThemeConstants.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          onTapOutside: (f) {
            FocusScope.of(context).unfocus();
          },
          controller: _searchController,
          decoration: InputDecoration(
            hintStyle: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: ThemeConstants.textSecondaryLight),
            hintText: 'Search income/expenses...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Iconsax.close_circle_bold),
              onPressed: () {
                _searchController.clear();
                _searchTransactions('');
              },
            ),
          ),
          onChanged: _searchTransactions,
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredTransactions.length,
        itemBuilder: (context, index) {
          final transaction = _filteredTransactions[index];
          return ListTile(
            leading: Icon(
              transaction['icon'],
              color: transaction['isIncome'] ? Colors.green : Colors.red,
            ),
            title: Text(transaction['title']),
            subtitle: Text(
              '${DateFormat('dd MMM yyyy').format(transaction['date'])} • ${transaction['category']}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: Text(
              '₹${transaction['amount'].toStringAsFixed(2)}',
              style: TextStyle(
                color: transaction['isIncome'] ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
