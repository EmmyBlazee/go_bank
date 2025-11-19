import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  // Dummy data for transactions
  final List<Map<String, dynamic>> _transactions = const [
    {
      'icon': Icons.swap_horiz,
      'title': 'Transfer to Moagji Olatubosun',
      'date': 'Today, 2:30 PM',
      'amount': -2500.00,
      'status': 'Successful',
      'type': 'debit',
      'currency': 'NGN',
    },
    {
      'icon': Icons.account_balance_wallet,
      'title': 'Salary Deposit',
      'date': 'Yesterday, 9:00 AM',
      'amount': 50000.00,
      'status': 'Successful',
      'type': 'credit',
      'currency': 'NGN',
    },
    {
      'icon': Icons.receipt,
      'title': 'DSTV Subscription',
      'date': '5 days ago, 6:30 PM',
      'amount': -1850.00,
      'status': 'Successful',
      'type': 'debit',
      'currency': 'NGN',
    },
    {
      'icon': Icons.swap_horiz,
      'title': 'Transfer from Jane Smith',
      'date': '1 week ago, 11:15 AM',
      'amount': 10000.00,
      'status': 'Successful',
      'type': 'credit',
      'currency': 'NGN',
    },
    {
      'icon': Icons.help_outline,
      'title': 'Pending Transfer',
      'date': '2 weeks ago, 3:45 PM',
      'amount': -5000.00,
      'status': 'Pending',
      'type': 'debit',
      'currency': 'NGN',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Transaction History',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        itemCount: _transactions.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey[200],
          height: 1,
        ),
        itemBuilder: (context, index) {
          final transaction = _transactions[index];
          return TransactionTile(transaction: transaction);
        },
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const TransactionTile({super.key, required this.transaction});

  String getCurrencySymbol(String currency) {
    switch (currency) {
      case 'NGN':
        return '₦';
      case 'USD':
        return '\$';
      default:
        return '₦';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isCredit = transaction['type'] == 'credit';
    final Color amountTextColor = isCredit ? Colors.black : const Color(0xFFD32F2F);
    final String amountSign = isCredit ? '+' : '-';
    final String currencySymbol = getCurrencySymbol(transaction['currency'] as String);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary.withOpacity(0.1),
            foregroundColor: AppColors.primary,
            child: Icon(transaction['icon'] as IconData),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction['date'],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$amountSign$currencySymbol${transaction['amount'].abs().toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: amountTextColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                transaction['status'],
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF00C853),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
