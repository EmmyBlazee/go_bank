import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_bank/app_routes.dart';
import 'package:go_bank/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AirtimePurchaseScreen extends StatefulWidget {
  const AirtimePurchaseScreen({super.key});

  @override
  State<AirtimePurchaseScreen> createState() => _AirtimePurchaseScreenState();
}

class _AirtimePurchaseScreenState extends State<AirtimePurchaseScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String? _selectedNetwork;
  bool _isBalanceHidden = true;
  bool _saveBeneficiary = false;
  bool _isFormValid = false;
  final List<String> _networks = ['MTN', 'Airtel', 'Glo', '9mobile'];
  final List<String> _quickAmounts = ['₦100', '₦200', '₦500', '₦1,000', '₦2,000'];

  @override
  void initState() {
    super.initState();
    _selectedNetwork = _networks.first;
    _phoneController.addListener(_validateForm);
    _amountController.addListener(_validateForm);
    _validateForm(); // Initial validation
  }

  void _validateForm() {
    final phone = _phoneController.text;
    final amount = _amountController.text;

    setState(() {
      _isFormValid = _selectedNetwork != null &&
                     phone.length == 11 &&
                     RegExp(r'^[0-9]+$').hasMatch(phone) &&
                     amount.isNotEmpty &&
                     double.tryParse(amount) != null &&
                     double.parse(amount) >= 50 &&
                     double.parse(amount) <= 100000;
    });
  }

  void _toggleBalanceVisibility() {
    setState(() => _isBalanceHidden = !_isBalanceHidden);
  }

  void _selectQuickAmount(String amount) {
    final numericAmount = amount.replaceAll('₦', '').replaceAll(',', '');
    _amountController.text = numericAmount;
  }

  void _onProceedToPay() {
    if (!_isFormValid) return;

    final selectedProvider = {'name': _selectedNetwork!, 'logo': _selectedNetwork!};
    final amount = double.parse(_amountController.text);

    Navigator.pushNamed(
      context,
      AppRoutes.airtimeConfirm,
      arguments: {
        'selectedProvider': selectedProvider,
        'phoneNumber': _phoneController.text,
        'amount': amount,
        'type': 'airtime', // Add transaction type
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom App Bar with curved bottom and Balance Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
                decoration: BoxDecoration(
                  color: AppColors.navy,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    // Back button and title
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 60),
                        Text(
                          'Airtime',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Nigerian flag and balance
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Row(
                            children: [
                              Container(width: 6.67, color: Colors.green),
                              Container(width: 6.66, color: Colors.white),
                              Container(width: 6.67, color: Colors.green),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Current Balance',
                          style: GoogleFonts.inter(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Balance amount with eye icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isBalanceHidden ? '********' : '₦155,600.24',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: Icon(
                            _isBalanceHidden ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white70,
                            size: 20,
                          ),
                          onPressed: _toggleBalanceVisibility,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Account Number
                    Text(
                      'Account Number: 1234567890', // Static for now, as per request
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Network + Phone Number Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: DropdownButton<String>(
                                      value: _selectedNetwork,
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      icon: const Icon(Icons.keyboard_arrow_down),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedNetwork = newValue;
                                          _validateForm();
                                        });
                                      },
                                      items: _networks.map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(value: value, child: Center(child: Text(value, style: GoogleFonts.inter(fontWeight: FontWeight.w600))));
                                      }).toList(),
                                    ),
                                  ),
                                  const VerticalDivider(thickness: 1, width: 1),
                                  Expanded(
                                    flex: 5,
                                    child: TextFormField(
                                      controller: _phoneController,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(11)],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        suffixIcon: const Icon(Icons.person, color: Colors.grey),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Amount Input
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Amount (₦)',
                        labelStyle: GoogleFonts.inter(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                        prefixText: '₦ ',
                        prefixStyle: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Color(0xFF0057FF)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Save Beneficiary Toggle
                    Row(
                      children: [
                        Checkbox(
                          value: _saveBeneficiary,
                          onChanged: (value) {
                            setState(() => _saveBeneficiary = value ?? false);
                          },
                          activeColor: const Color(0xFF0057FF),
                        ),
                        Text(
                          'Save this number',
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Quick Select Amount Buttons
                    Text(
                      'Quick Select',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: _quickAmounts.map((amount) {
                        return InkWell(
                          onTap: () => _selectQuickAmount(amount),
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.grey[200]!),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              amount,
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 32),

                    // Pay Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isFormValid ? _onProceedToPay : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isFormValid ? const Color(0xFF0057FF) : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Proceed to Pay',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
