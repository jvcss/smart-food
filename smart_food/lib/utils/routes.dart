import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_food/src/blocs/authentication/authentication_bloc.dart';
import 'package:smart_food/src/blocs/authentication/authentication_state.dart';
import 'package:smart_food/src/screens/four_oh_four.dart';
import 'package:smart_food/src/screens/login_screen.dart';
import 'package:smart_food/src/screens/dashboard_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';

  static String getInitialRoute(AuthenticationState state) {
    if (state is AuthenticationAuthenticated) {
      return dashboard;
    } else {
      return login;
    }
  }

  static RouteFactory generateRoutes(BuildContext context) {
    final authState = context.read<AuthenticationBloc>().state;

    return (settings) {
      switch (settings.name) {
        case home:
          return MaterialPageRoute(
            builder: (context) => Navigator(
              initialRoute: getInitialRoute(authState),
              onGenerateRoute: generateRoutes(context),
            ),
          );
        case login:
          return MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          );
        case dashboard:
          return MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          );
        default:
          return MaterialPageRoute(
            builder: (context) => const FourOhFourScreen(),
          );
      }
    };
  }
}
