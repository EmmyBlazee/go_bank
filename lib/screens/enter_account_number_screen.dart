import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_bank/app_routes.dart';
import '../colors.dart';
import 'package:intl/intl.dart';

class EnterAccountNumberScreen extends StatefulWidget {
  final String selectedBank;

  const EnterAccountNumberScreen({
    super.key,
    required this.selectedBank,
  });

  @override
  State<EnterAccountNumberScreen> createState() => _EnterAccountNumberScreenState();
}

class _EnterAccountNumberScreenState extends State<EnterAccountNumberScreen> {
  final TextEditingController _accountController = TextEditingController();
  bool _isValidAccount = false;
  String _recipientName = '';

  @override
  void initState() {
    super.initState();
    _accountController.addListener(_validateAccountNumber);
  }

  void _validateAccountNumber() {
    final accountNumber = _accountController.text;
    setState(() {
      _isValidAccount =
          accountNumber.length == 10 && RegExp(r'^\d+$').hasMatch(accountNumber);
      if (_isValidAccount) {
        // Mock recipient name resolution
        _recipientName = _getMockRecipientName(accountNumber);
      } else {
        _recipientName = '';
      }
    });
  }

  String _getMockRecipientName(String accountNumber) {
    // Mock recipient names based on account number
    final mockNames = {
      '1234567890': 'John Doe',
      '0987654321': 'Jane Smith',
      '1111111111': 'Alice Johnson',
      '2222222222': 'Bob Wilson',
      '1023456789': 'Mogaji Oladutusin',
    };
    return mockNames[accountNumber] ?? 'Account Owner';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7), // Light pink/lavender background
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Send to bank'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              // Selected Bank Display
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.account_balance,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.selectedBank,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              if (_isValidAccount && _recipientName.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  _recipientName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                     const Icon(Icons.chevron_right, color: Colors.black),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Enter Account Number',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              
             
              const SizedBox(height: 15),
              TextField(
                controller: _accountController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  hintText: '1234567890',
                  prefixIcon: const Icon(
                    Icons.person,
                    color: AppColors.primary,
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
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                  filled: true,
                  fillColor: AppColors.primary.withOpacity(0.1),
                ),
              ),
              if (_isValidAccount && _recipientName.isNotEmpty) ...[
                const SizedBox(height: 2),

              ],
              const SizedBox(height: 10),
              Divider(color: AppColors.primary, height:1),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isValidAccount
                    ? () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.enterTransferAmount,
                          arguments: {
                            'selectedBank': {'name': widget.selectedBank},
                            'accountNumber': _accountController.text,
                            'recipientName': _recipientName,
                          },
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isValidAccount ? AppColors.primary : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Next',
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
      ),
    );
  }

  @override
  void dispose() {
    _accountController.dispose();
    super.dispose();
  }
}
