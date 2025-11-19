import 'package:flutter/material.dart';
import 'package:go_bank/app_routes.dart';
import 'package:go_bank/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class BillsCategoryScreen extends StatefulWidget {
  const BillsCategoryScreen({super.key});

  @override
  State<BillsCategoryScreen> createState() => _BillsCategoryScreenState();
}

class _BillsCategoryScreenState extends State<BillsCategoryScreen> {
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

    final List<Map<String, dynamic>> billCategories = [
      {
        'name': 'Cable Subscription',
        'icon': Icons.tv,
        'route': AppRoutes.billsProvider,
        'color': const Color(0xFF3D5AFE),
        'category': {'name': 'Cable Subscription', 'icon': Icons.tv, 'color': const Color(0xFF3D5AFE)},
      },
      {
        'name': 'Betting, Lottery and Gaming',
        'icon': Icons.sports_soccer,
        'route': AppRoutes.billsProvider,
        'color': const Color(0xFF3D5AFE),
        'category': {'name': 'Betting, Lottery and Gaming', 'icon': Icons.sports_soccer, 'color': const Color(0xFF3D5AFE)},
      },
      {
        'name': 'Electricity',
        'icon': Icons.flash_on,
        'route': AppRoutes.billsProvider,
        'color': const Color(0xFF3D5AFE),
        'category': {'name': 'Electricity', 'icon': Icons.flash_on, 'color': const Color(0xFF3D5AFE)},
      },
      {
        'name': 'Event Tickets',
        'icon': Icons.event,
        'route': AppRoutes.billsProvider,
        'color': const Color(0xFF3D5AFE),
        'category': {'name': 'Event Tickets', 'icon': Icons.event, 'color': const Color(0xFF3D5AFE)},
      },
      {
        'name': 'Government Payment',
        'icon': Icons.account_balance,
        'route': AppRoutes.billsProvider,
        'color': const Color(0xFF3D5AFE),
        'category': {'name': 'Government Payment', 'icon': Icons.account_balance, 'color': const Color(0xFF3D5AFE)},
      },
      {
        'name': 'Remita',
        'icon': Icons.payment,
        'route': AppRoutes.billsProvider,
        'color': const Color(0xFF3D5AFE),
        'category': {'name': 'Remita', 'icon': Icons.payment, 'color': const Color(0xFF3D5AFE)},
      },
      {
        'name': 'Travel and Hotel',
        'icon': Icons.flight,
        'route': AppRoutes.billsProvider,
        'color': const Color(0xFF3D5AFE),
        'category': {'name': 'Travel and Hotel', 'icon': Icons.flight, 'color': const Color(0xFF3D5AFE)},
      },
      {
        'name': 'Utilities',
        'icon': Icons.build,
        'route': AppRoutes.billsProvider,
        'color': const Color(0xFF3D5AFE),
        'category': {'name': 'Utilities', 'icon': Icons.build, 'color': const Color(0xFF3D5AFE)},
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Bills',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Balance Section - Same as Transfer Choice Screen
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.navy,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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

            // Bill Options List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                itemCount: billCategories.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final category = billCategories[index];
                  return _BillCategoryCard(
                    name: category['name'],
                    icon: category['icon'],
                    color: category['color'],
                    onTap: () {
                      Navigator.pushNamed(context, category['route'], arguments: {
                        'selectedCategory': category['category'],
                        'type': 'bills', // Add transaction type
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BillCategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _BillCategoryCard({
    required this.name,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width:30,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),

            // Category Name
            Expanded(
              child: Text(
                name,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),

            // Right Arrow
           
          ],
        ),
      ),
    );
  }
}
