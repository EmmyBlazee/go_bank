import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_bank/app_routes.dart';
import '../colors.dart';
import '../widgets/pin_modal.dart';

class BillsConfirmScreen extends StatelessWidget {
  final Map<String, dynamic> selectedCategory;
  final Map<String, String> selectedProvider;
  final Map<String, dynamic> selectedPackage;
  final String smartcardNumber;
  final double amount;

  const BillsConfirmScreen({
    super.key,
    required this.selectedCategory,
    required this.selectedProvider,
    required this.selectedPackage,
    required this.smartcardNumber,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final String fieldLabel = selectedCategory['name'] == 'Electricity'
        ? 'Meter Number'
        : selectedCategory['name'] == 'Internet'
            ? 'Account Number'
            : selectedCategory['name'] == 'Water'
                ? 'Customer ID'
                : 'Smart Card Number';

    return Scaffold(
      backgroundColor: AppColors.white, // White background for inner pages
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Confirm Payment',
          style: GoogleFonts.sora( // Using Sora font
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0, // Flat app bar
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text(
              'Confirm Details',
              style: GoogleFonts.sora( // Using Sora font
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please review the details before proceeding',
              style: GoogleFonts.sora( // Using Sora font
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),
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
                        '₦${amount.toStringAsFixed(0)}',
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
                        'Fee',
                        style: GoogleFonts.sora( // Using Sora font
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        '₦0.00',
                        style: GoogleFonts.sora( // Using Sora font
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: GoogleFonts.sora( // Using Sora font
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        '₦${amount.toStringAsFixed(0)}',
                        style: GoogleFonts.sora( // Using Sora font
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.pin,
                  arguments: {
                    'selectedCategory': selectedCategory,
                    'selectedProvider': selectedProvider,
                    'selectedPackage': selectedPackage,
                    'smartcardNumber': smartcardNumber,
                    'amount': amount,
                    'type': 'bills',
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Pay Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
