import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'providers/home_navigation_provider.dart';
import 'providers/stats_provider.dart';
import 'providers/testimonial_provider.dart';
import 'router/app_router.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (_) {
    // Firebase already initialized or config error — app continues
  }
  final authService = AuthService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authService),
        ChangeNotifierProvider(create: (_) => HomeNavigationProvider()),
        ChangeNotifierProvider(create: (_) => TestimonialProvider()),
        ChangeNotifierProvider(create: (_) => StatsProvider()),
      ],
      child: ImaginicaApp(router: buildRouter(authService)),
    ),
  );
}

class ImaginicaApp extends StatelessWidget {
  final GoRouter router;

  const ImaginicaApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Imaginica Space — Modern Digital Product Studio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
