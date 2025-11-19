import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_bank/app_routes.dart';
import '../colors.dart';
import '../widgets/custom_button.dart';

class BillsSuccessScreen extends StatelessWidget {
  final Map<String, dynamic> selectedCategory;
  final Map<String, String> selectedProvider;
  final Map<String, dynamic> selectedPackage;
  final String smartcardNumber;
  final double amount;
  final String currency;

  const BillsSuccessScreen({
    super.key,
    required this.selectedCategory,
    required this.selectedProvider,
    required this.selectedPackage,
    required this.smartcardNumber,
    required this.amount,
    this.currency = 'NGN',
  });

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
    final String fieldLabel = selectedCategory['name'] == 'Electricity'
        ? 'Meter Number'
        : selectedCategory['name'] == 'Internet'
            ? 'Account Number'
            : selectedCategory['name'] == 'Water'
                ? 'Customer ID'
                : 'Smart Card Number';
    final String currencySymbol = getCurrencySymbol(currency);

    return Scaffold(
      backgroundColor: AppColors.white, // White background for inner pages
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0, // Flat app bar
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.primary),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.home, (route) => false);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - kToolbarHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.success, // Using success color
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            const SizedBox(height: 24),
            Text(
              'Payment Successful!',
              style: GoogleFonts.sora( // Using Sora font
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your bill payment has been completed successfully',
              textAlign: TextAlign.center,
              style: GoogleFonts.sora( // Using Sora font
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.white, // White background for card
                borderRadius: BorderRadius.circular(16), // Rounded corners
                border: Border.all(color: Colors.grey[200]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16), // Updated to match guidelines
                        ),
                        child: Center(
                          child: Text(
                            selectedProvider['logo']!,
                            style: GoogleFonts.sora( // Using Sora font
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedProvider['name']!,
                            style: GoogleFonts.sora( // Using Sora font
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            selectedCategory['name'],
                            style: GoogleFonts.sora( // Using Sora font
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        fieldLabel,
                        style: GoogleFonts.sora( // Using Sora font
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        smartcardNumber,
                        style: GoogleFonts.sora( // Using Sora font
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Package',
                        style: GoogleFonts.sora( // Using Sora font
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        selectedPackage['name'],
                        style: GoogleFonts.sora( // Using Sora font
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount',
                        style: GoogleFonts.sora( // Using Sora font
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        '$currencySymbol${amount.toStringAsFixed(0)}',
                        style: GoogleFonts.sora( // Using Sora font
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transaction ID',
                        style: GoogleFonts.sora( // Using Sora font
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        'TXN${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                        style: GoogleFonts.sora( // Using Sora font
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date & Time',
                        style: GoogleFonts.sora( // Using Sora font
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                        style: GoogleFonts.sora( // Using Sora font
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Implement receipt download
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Receipt download coming soon')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // Updated to match guidelines
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Download Receipt',
                      style: GoogleFonts.sora( // Using Sora font
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomButton( // Using custom button
                    text: 'Back to Home',
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.home, (route) => false);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
