import 'package:flutter/material.dart';
import 'package:smart_food/src/screens/login_screen.dart';
import 'package:smart_food/src/screens/dashboard_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String dashboard = '/dashboard';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    dashboard: (context) => const DashboardScreen(),
  };
}
