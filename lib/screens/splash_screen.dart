import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import '../services/auth_service.dart';
import '../app_routes.dart';

class HalfCircleSpinnerPainter extends CustomPainter {
  final double progress;
  final Color color;

  HalfCircleSpinnerPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 4;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    // Draw the half circle border
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, -pi / 2, pi, false, paint);

    // Draw the animated progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -pi / 2, pi * progress, false, progressPaint);
  }

  @override
  bool shouldRepaint(HalfCircleSpinnerPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Fade-in animation
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() => _opacity = 1.0);
      }
    });

    // Spinner rotation
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _startNavigationTimer();
  }

  void _startNavigationTimer() {
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        final authService = Provider.of<AuthService>(context, listen: false);
        String nextRouteName;

        // After splash, check auth state to determine next screen
        if (!authService.hasCompletedOnboarding) {
          nextRouteName = AppRoutes.onboarding;
        } else if (!authService.isLoggedIn) {
          nextRouteName = AppRoutes.welcome;
        } else {
          nextRouteName = AppRoutes.home;
        }

        Navigator.pushReplacementNamed(
          context,
          nextRouteName,
          arguments: nextRouteName == AppRoutes.home ? {'initialIndex': 0} : null,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // Centered Logo + Text
          Center(
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo Placeholder
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'GB',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Go Bank',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Loading Spinner at bottom
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  final rotationValue = _rotationAnimation.value * 2 * 3.14159;
                  return Transform.rotate(
                    angle: rotationValue,
                    alignment: Alignment.center,
                    child: Container(
                      width: 60,
                      height: 60,
                      child: CustomPaint(
                        painter: HalfCircleSpinnerPainter(
                          progress: 1.0, // Always show full half-circle
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
