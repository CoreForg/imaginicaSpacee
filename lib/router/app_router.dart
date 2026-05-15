import 'package:go_router/go_router.dart';
import '../screens/admin/admin_login_page.dart';
import '../screens/admin/admin_screen.dart';
import '../screens/home/home_screen.dart';
import '../services/auth_service.dart';

GoRouter buildRouter(AuthService authService) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: authService,
    redirect: (context, state) {
      final loggedIn = authService.isLoggedIn;
      final location = state.matchedLocation;

      if (location.startsWith('/admin/dashboard') && !loggedIn) {
        return '/admin';
      }
      if (location == '/admin' && loggedIn) {
        return '/admin/dashboard';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminLoginPage(),
        routes: [
          GoRoute(
            path: 'dashboard',
            builder: (context, state) => const AdminScreen(),
          ),
        ],
      ),
    ],
  );
}
