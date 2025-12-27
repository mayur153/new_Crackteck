import 'package:flutter/material.dart';
import '../screens/Delivery_person/delivery_dashboard.dart';
import '../screens/Delivery_person/delivery_home_tab.dart';
import '../screens/Delivery_person/delivery_notification.dart';
import '../screens/Delivery_person/map_with-start.dart';
import '../screens/Delivery_person/product_to_be_deliveried_screen.dart';
import '../screens/sales_person/Sales_new_follow-up_screen.dart';
import '../screens/sales_person/Task.dart';
import '../screens/sales_person/sale_person_edit_lead_screen.dart';
import '../screens/sales_person/sale_person_notification.dart';
import '../screens/sales_person/sales_add_new_meeting.dart';
import '../screens/sales_person/sales_attendance_screen.dart';
import '../screens/sales_person/sales_new_lead_screens.dart';
import '../screens/sales_person/sales_new_quotation.dart';
import '../screens/sales_person/sales_person_edit_followup_screen.dart';
import '../screens/sales_person/sales_person_edit_meeting_screen.dart';
import '../screens/sales_person/sales_person_edit_quotation_screen.dart';
import '../screens/sales_person/sales_person_meeting_tabs.dart';
import '../screens/sales_person/sales_person_sales_overview_screen.dart';
import '../screens/sales_person/sales_personal_info_screen.dart';
import '../screens/sales_person/sales_privacy_screen.dart';
import '../screens/sales_person/sales_product_screen.dart';
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

        case AppRoutes.NewLeadScreen:
        final args = settings.arguments as SalesnewleadArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              NewLeadScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.NewFollowUpScreen:
        final args = settings.arguments as SalesnewfollowupArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              NewFollowUpScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.NewMeetingScreen:
        final args = settings.arguments as SalesnewmeetingArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              NewMeetingScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.NewQuotationScreen:
        final args = settings.arguments as SalesnewquotationArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              NewQuotationScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.ProductScreen:
        final args = settings.arguments as SalesproductArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              ProductScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.EditLeadScreen:
        final args = settings.arguments as SaleseditleadArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              EditLeadScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.EditFollowUpScreen:
        final args = settings.arguments as SaleseditfollowupArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              EditFollowUpScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.EditMeetingScreen:
        final args = settings.arguments as SaleseditmeetingArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              EditMeetingScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.EditQuotationScreen:
        final args = settings.arguments as SaleseditquotationArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              EditQuotationScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        //delivery man cases
      case AppRoutes.DeliveryPersonHomeTab:
        final args = settings.arguments as deliveryhomeArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              DeliveryPersonHomeTab(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.ProductToBeDeliveredScreen:
        final args = settings.arguments as deliveryproducttobedeliveredArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              ProductToBeDeliveredScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.DeliveryDashboard:
        final args = settings.arguments as deliverydasboardArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              DeliveryDashboard(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.DeliveryNotificationScreen:
        final args = settings.arguments as deliverynotificationArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              DeliveryNotificationScreen(roleId: args.roleId, roleName: args.roleName),
          settings: settings,
        );

        case AppRoutes.DeliverypickupparcelScreen:
        final args = settings.arguments as deliverypickupparcelArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              DeliverypickupparcelScreen(roleId: args.roleId, roleName: args.roleName),
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

