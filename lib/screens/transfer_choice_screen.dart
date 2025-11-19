import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors.dart';
import '../app_routes.dart';

class TransferChoiceScreen extends StatefulWidget {
  const TransferChoiceScreen({super.key});

  @override
  State<TransferChoiceScreen> createState() => _TransferChoiceScreenState();
}

class _TransferChoiceScreenState extends State<TransferChoiceScreen> {
  bool _isBalanceHidden = true;

  void _toggleBalanceVisibility() {
    setState(() => _isBalanceHidden = !_isBalanceHidden);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Block back button
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return; // If the system back button was handled, do nothing.
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Custom App Bar with curved bottom
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
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
                            },
                          ),
                          const SizedBox(width: 60),
                          Text(
                            'Transfer',
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
                    ],
                  ),
                ),

                // Middle Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose a way to send money',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkGray,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Send to Go Bank button
                      _buildTransferOption(
                        context,
                        icon: Icons.send,
                        title: 'Send to Go Bank',
                        subtitle: 'Send money to GGB account',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Coming soon')),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      // Send to Other bank button
                      _buildTransferOption(
                        context,
                        icon: Icons.refresh,
                        title: 'Send to Other bank',
                        subtitle: 'Send money to other banks',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.sendToBank);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransferOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(0),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 8,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
