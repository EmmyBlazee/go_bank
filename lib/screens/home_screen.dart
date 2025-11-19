import 'package:flutter/material.dart';
import '../colors.dart';
import '../app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isBalanceHidden = true;
  String _selectedCurrency = 'NGN'; // 'NGN' or 'USD'

  void _toggleBalanceVisibility() {
    setState(() => _isBalanceHidden = !_isBalanceHidden);
  }

  void _onCurrencyChanged(String? newCurrency) {
    if (newCurrency != null) {
      setState(() => _selectedCurrency = newCurrency);
    }
  }

  Future<void> _onRefresh() async {
    // Simulate refresh delay - in a real app, this would fetch updated balance data
    await Future.delayed(const Duration(seconds: 1));
    // Here you would typically call an API to refresh balance
    setState(() {
      // Update any refreshed data if needed
    });
  }

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
    final currencySymbol = getCurrencySymbol(_selectedCurrency);
    final balance = _selectedCurrency == 'NGN' ? '${currencySymbol}155,600.24' : '${currencySymbol}2,450.75';
    final accountNumber = _selectedCurrency == 'NGN' ? '335549312' : '1234567890';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        title: Row(
          children: [
            const Text(
              'Hi, Fitsbyfunmi',
              style: TextStyle(
                color: Color(0xFF10142E),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.grey, size: 20),
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.notifications_outlined,
                  color: Color(0xFF10142E), size: 26),
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.notifications),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // BALANCE CARD
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.navy,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Currency Dropdown
                    DropdownButton<String>(
                      value: _selectedCurrency,
                      dropdownColor: const Color(0xFF10142E),
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
                      items: const [
                        DropdownMenuItem(
                          value: 'NGN',
                          child: Text('🇳🇬 NGN'),
                        ),
                        DropdownMenuItem(
                          value: 'USD',
                          child: Text('🇺🇸 USD'),
                        ),
                      ],
                      onChanged: _onCurrencyChanged,
                    ),
                    const SizedBox(height: 4),

                    // "Current Balance" Label
                    const Text(
                      'Current Balance',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 8),

                    // Balance Amount + Visibility Toggle
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _isBalanceHidden
                                ? '********'
                                : balance,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isBalanceHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
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
                      'Account Number: ${_selectedCurrency == 'NGN' ? accountNumber : '1234567890'}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // QUICK ACTIONS (No title, as in screenshot)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildQuickAction(
                        context,
                        Icons.swap_horiz,
                        'Transfer',
                        () {
                          if (_selectedCurrency == 'USD') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Coming soon')),
                            );
                          } else {
                            Navigator.pushNamed(context, AppRoutes.transferChoice);
                          }
                        }),
                    _buildQuickAction(
                        context,
                        Icons.phone,
                        'Airtime',
                        () {
                          if (_selectedCurrency == 'USD') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Coming soon')),
                            );
                          } else {
                            Navigator.pushNamed(context, AppRoutes.airtimePurchase);
                          }
                        }),
                    _buildQuickAction(
                        context,
                        Icons.wifi,
                        'Data',
                        () {
                          if (_selectedCurrency == 'USD') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Coming soon')),
                            );
                          } else {
                            Navigator.pushNamed(context, AppRoutes.dataPage);
                          }
                        }),
                    _buildQuickAction(
                        context,
                        Icons.receipt,
                        'Bills',
                        () {
                          if (_selectedCurrency == 'USD') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Coming soon')),
                            );
                          } else {
                            Navigator.pushNamed(context, AppRoutes.billsCategory);
                          }
                        }),
                    _buildQuickAction(
                        context,
                        Icons.more_horiz,
                        'More',
                        () {
                          if (_selectedCurrency == 'USD') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Coming soon')),
                            );
                          } else {
                            Navigator.pushNamed(context, AppRoutes.moreServices);
                          }
                        }),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // OTHERS
              const Text(
                'Others',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF10142E),
                ),
              ),
              const SizedBox(height: 16),

              _buildOtherItem(
                context,
                Icons.history,
                'Transaction History',
                'See your recent transactions',
                onTap: () => Navigator.pushNamed(
                    context, AppRoutes.transactionHistory),
              ),
              const SizedBox(height: 12),
              _buildOtherItem(
                context,
                Icons.show_chart,
                'Savings Investment',
                'See how you\'ve invest and earn',
              ),
              const SizedBox(height: 12),
              _buildOtherItem(
                context,
                Icons.flag,
                'Savings Goals',
                'See the goals you set yourself',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // QUICK ACTION
  Widget _buildQuickAction(
      BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(29),
            ),
            child: Icon(icon, color: AppColors.primary, size: 25),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF10142E)),
          ),
        ],
      ),
    );
  }

  // OTHER ITEM
  Widget _buildOtherItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
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
              child: Icon(icon, color: AppColors.primary, size: 25),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 104, 119, 218),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              const Icon(Icons.arrow_forward_ios,
                  color: Colors.grey, size: 14),
          ],
        ),
      ),
    );
  }
}
