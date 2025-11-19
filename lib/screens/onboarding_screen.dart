import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import '../services/auth_service.dart';
import '../app_routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Send Money',
      'body': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'buttonText': 'Next',
    },
    {
      'title': 'Pay Your Bills',
      'body': 'Pay from anywhere, anytime. Manage your bills effortlessly with our secure payment system.',
      'buttonText': 'Next',
    },
    {
      'title': 'Manage Your Cards',
      'body': 'Keep track of all your cards in one place. Add, remove, and organize your payment methods.',
      'buttonText': 'Get Started',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return PopScope(
      canPop: false, // Block back button
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                return _buildPage(
                  pageIndex: index,
                  title: _onboardingData[index]['title']!,
                  body: _onboardingData[index]['body']!,
                  buttonText: _onboardingData[index]['buttonText']!,
                  isLastPage: index == _onboardingData.length - 1,
                );
              },
            ),
            if (_currentPage < _onboardingData.length - 1)
              Positioned(
                top: 50,
                right: 24,
                child: TextButton(
                  onPressed: () {
                    authService.completeOnboarding();
                    Navigator.pushReplacementNamed(context, AppRoutes.welcome);
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 50,
              left: 24,
              child: Row(
                children: List.generate(
                  _onboardingData.length,
                  (index) => _buildDot(index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required int pageIndex,
    required String title,
    required String body,
    required String buttonText,
    required bool isLastPage,
  }) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Onboard Screens${pageIndex + 1}.png',
            height: 300,
            width: 600,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            body,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(
              onPressed: () {
                if (isLastPage) {
                  authService.completeOnboarding();
                  Navigator.pushReplacementNamed(context, AppRoutes.welcome);
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0540F2),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24)
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 16 : 7,
      height: 6,
      decoration: BoxDecoration(
        color: _currentPage == index ? AppColors.primary : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
