import 'package:flutter/material.dart';
import '../screens/sales_person/Task.dart';
import '../screens/sales_person/sale_person_notification.dart';
import '../screens/sales_person/sales_attendance_screen.dart';
import '../screens/sales_person/sales_person_meeting_tabs.dart';
import '../screens/sales_person/sales_person_sales_overview_screen.dart';
import '../screens/sales_person/sales_personal_info_screen.dart';
import '../screens/sales_person/sales_privacy_screen.dart';
import '../screens/sales_person/sales_quatation_tabs_screen.dart';
import '../screens/sales_person/salesperson_ followup_ screen.dart';
import '../screens/sales_person/salesperson_dashboard.dart';

import '../login_screen.dart';
import '../role_screen.dart';
import '../screens/sales_person/salesperson_leads_screen.dart';
import '../screens/sales_person/salesperson_profile_tab.dart';
import 'app_routes.dart' hide DashboardScreen;


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

        case AppRoutes.SalespersonDashboard:
        final args = settings.arguments as SalespersonDashboard?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              SalespersonDashboard(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

      case AppRoutes.NotificationScreen:
        final args = settings.arguments as NotificationArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              NotificationScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

      case AppRoutes.TaskScreen:
        final args = settings.arguments as TaskArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              TaskScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.SalesOverviewScreen:
        final args = settings.arguments as SalesOverviewArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              SalesOverviewScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.SalesPersonLeadsScreen:
        final args = settings.arguments as SalesleadsArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              SalesPersonLeadsScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.SalesPersonFollowUpScreen:
        final args = settings.arguments as SalesfollowupArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              SalesPersonFollowUpScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.SalesPersonMeetingScreen:
        final args = settings.arguments as SalesmeetingArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              SalesPersonMeetingScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.SalesPersonQuotationScreen:
        final args = settings.arguments as SalesquotationArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              SalesPersonQuotationScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.SalesPersonMoreScreen:
        final args = settings.arguments as SalespersonArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              SalesPersonMoreScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.PrivacyPolicyScreen:
        final args = settings.arguments as SalespolicyArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              PrivacyPolicyScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.SalesPersonPersonalInfoScreen:
        final args = settings.arguments as SalespersonalinfoArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              SalesPersonPersonalInfoScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.SalesPersonAttendanceScreen:
        final args = settings.arguments as SalesattendanceArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              SalesPersonAttendanceScreen(roleId: args.roleId, roleName: args.roleName),
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

