import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isFilled;
  final bool isLoading;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isFilled = true,
    this.isLoading = false,
    this.borderRadius = 16.0, // Updated to match design guidelines
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isFilled ? AppColors.primary : Colors.transparent,
        foregroundColor: isFilled ? Colors.white : AppColors.primary,
        side: isFilled ? null : const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
        minimumSize: const Size(double.infinity, 56), // Updated height to 56px
        elevation: 0, // Flat buttons as per guidelines
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              text,
              style: GoogleFonts.sora( // Using Sora font
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isFilled ? Colors.white : AppColors.primary,
              ),
            ),
    );
  }
}
