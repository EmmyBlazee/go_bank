import 'package:flutter/material.dart';

class BankLogo extends StatelessWidget {
  final String logo;
  final double size;

  const BankLogo({
    super.key,
    required this.logo,
    this.size = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Center(
        child: Text(
          logo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
            fontSize: size * 0.2,
          ),
        ),
      ),
    );
  }
}
