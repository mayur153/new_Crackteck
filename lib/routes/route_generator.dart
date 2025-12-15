import 'package:flutter/material.dart';


import '../login_screen.dart';
import '../role_screen.dart';
import 'app_routes.dart';


/// Centralized route generator for the application
class RouteGenerator {
  RouteGenerator._(); // Private constructor to prevent instantiation

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.roleSelection:
        return MaterialPageRoute(
          builder: (_) => const rolesccreen(),
          settings: settings,
        );

      case AppRoutes.login:
        final args = settings.arguments as LoginArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              LoginScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );


      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text('No route defined for $routeName')),
      ),
    );
  }
}

