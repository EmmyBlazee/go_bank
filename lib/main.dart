import 'package:flutter/material.dart';
import 'package:go_bank/screens/home_screen.dart';
import 'package:go_bank/screens/onboarding_screen.dart';
import 'package:go_bank/screens/splash_screen.dart';
import 'package:go_bank/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize auth service
  final authService = AuthService();
  await authService.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => authService,
      child: MainApp(authService: authService),
    ),
  );
}

class MainApp extends StatelessWidget {
  final AuthService authService;
  const MainApp({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Bank',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Sora',
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: authService.getRedirectPath(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
