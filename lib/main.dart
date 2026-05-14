import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/home_navigation_provider.dart';
import 'providers/testimonial_provider.dart';
import 'screens/home/home_screen.dart';
import 'screens/admin/admin_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeNavigationProvider()),
        ChangeNotifierProvider(create: (_) => TestimonialProvider()),
      ],
      child: const ImaginicaApp(),
    ),
  );
}

class ImaginicaApp extends StatelessWidget {
  const ImaginicaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Imaginica Space — Modern Digital Product Studio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/admin': (context) => const AdminScreen(),
      },
    );
  }
}
