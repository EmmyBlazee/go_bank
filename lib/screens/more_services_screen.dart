import 'package:flutter/material.dart';
import 'package:go_bank/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreServicesScreen extends StatelessWidget {
  const MoreServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        'icon': Icons.swap_horiz,
        'label': 'Transfer',
        'onTap': () => Navigator.pushNamed(context, AppRoutes.transferChoice),
      },
      {
        'icon': Icons.phone_android,
        'label': 'Airtime',
        'onTap': () => Navigator.pushNamed(context, AppRoutes.airtimeProvider),
      },
      {
        'icon': Icons.wifi,
        'label': 'Data',
        'onTap': () => Navigator.pushNamed(context, AppRoutes.dataProvider),
      },
      {
        'icon': Icons.receipt,
        'label': 'Bills',
        'onTap': () => Navigator.pushNamed(context, AppRoutes.billsCategory),
      },
      {
        'icon': Icons.lightbulb,
        'label': 'Electricity',
        'onTap': () => Navigator.pushNamed(context, AppRoutes.billsCategory),
      },
      {
        'icon': Icons.security,
        'label': 'Assurance',
        'onTap': () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Assurance service coming soon!')),
            ),
      },
      {
        'icon': Icons.card_giftcard,
        'label': 'Voucher',
        'onTap': () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Voucher service coming soon!')),
            ),
      },
    ];

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
          'More Service',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(24.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1.0,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return ServiceButton(
            icon: service['icon'],
            label: service['label'],
            onTap: service['onTap'],
          );
        },
      ),
    );
  }
}

class ServiceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ServiceButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEAF2FF), // Light blue background
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFF3366FF), // Primary blue
              size: 36,
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3366FF), // Primary blue
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}