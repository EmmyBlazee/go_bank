import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_bank/app_routes.dart';
import '../colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class BillsSmartcardScreen extends StatefulWidget {
  final Map<String, dynamic> selectedCategory;
  final Map<String, String> selectedProvider;
  final Map<String, dynamic> selectedPackage;

  const BillsSmartcardScreen({
    super.key,
    required this.selectedCategory,
    required this.selectedProvider,
    required this.selectedPackage,
  });

  @override
  State<BillsSmartcardScreen> createState() => _BillsSmartcardScreenState();
}

class _BillsSmartcardScreenState extends State<BillsSmartcardScreen> {
  final TextEditingController _smartcardController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isCustomAmount = widget.selectedPackage['price'] == 0;
    final String fieldLabel = widget.selectedCategory['name'] == 'Electricity'
        ? 'Meter Number'
        : widget.selectedCategory['name'] == 'Internet'
            ? 'Account Number'
            : widget.selectedCategory['name'] == 'Water'
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
          widget.selectedProvider['name']!,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
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
                      widget.selectedProvider['logo']!,
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
                      widget.selectedProvider['name']!,
                      style: GoogleFonts.sora( // Using Sora font
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      widget.selectedPackage['name'],
                      style: GoogleFonts.sora( // Using Sora font
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Enter Details',
              style: GoogleFonts.sora( // Using Sora font
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please provide the required information',
              style: GoogleFonts.sora( // Using Sora font
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),
            CustomTextField( // Using custom text field
              controller: _smartcardController,
              labelText: fieldLabel,
              hintText: 'Enter $fieldLabel',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            if (isCustomAmount)
              CustomTextField( // Using custom text field
                controller: _amountController,
                labelText: 'Amount (₦)',
                hintText: 'Enter amount',
                prefixIcon: Icons.attach_money,
                keyboardType: TextInputType.number,
              ),
            const Spacer(),
            CustomButton( // Using custom button
              text: 'Continue',
              onPressed: () {
                if (_smartcardController.text.isNotEmpty &&
                    (!isCustomAmount || _amountController.text.isNotEmpty)) {
                  final amount = isCustomAmount
                      ? double.tryParse(_amountController.text) ?? 0.0
                      : (widget.selectedPackage['price'] as num).toDouble();

                  Navigator.pushNamed(
                    context,
                    AppRoutes.billsConfirm,
                    arguments: {
                      'selectedCategory': widget.selectedCategory,
                      'selectedProvider': widget.selectedProvider,
                      'selectedPackage': widget.selectedPackage,
                      'smartcardNumber': _smartcardController.text,
                      'amount': amount
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _smartcardController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
