/// App-wide route name constants
class AppRoutes {
  AppRoutes._(); // Private constructor to prevent instantiation

  // Initial Route
  static const String roleSelection = '/';

  // Login Route (unified for all roles)
  static const String login = '/login';

  // OTP Verification Route
  static const String otpVerification = '/otp-verification';

  // Sign Up Routes
  static const String signUp = '/signup';

  // 🔹 TEMP DASHBOARD ROUTES (ADD THESE)
  static const String adminDashboard = '/admin-dashboard';
  static const String residentDashboard = '/resident-dashboard';
  static const String securityDashboard = '/security-dashboard';


  static const String SalespersonDashboard = '/salesperson_dashboard.dart';
  static const String NotificationScreen = '/salesperson_notification';
  static const String TaskScreen = '/task';
  static const String SalesOverviewScreen = '/sales_overview';
  static const String SalesPersonLeadsScreen = '/sales_leads';
  static const String SalesPersonFollowUpScreen = '/sale_followup';
  static const String SalesPersonMeetingScreen = '/sale_meeting';
  static const String SalesPersonQuotationScreen = '/sale_quatation';


}

/// Route arguments for passing data between screens
class LoginArguments {
  final int roleId;
  final String roleName;

  LoginArguments({required this.roleId, required this.roleName});
}

class OtpArguments {
  final int roleId;
  final String roleName;
  final String phoneNumber;

  OtpArguments({
    required this.roleId,
    required this.roleName,
    required this.phoneNumber,
  });
}

class DashboardScreen {
  final int roleId;
  final String roleName;

  DashboardScreen({required this.roleId, required this.roleName});
}

class SignUpArguments {
  final int roleId;
  final String roleName;

  SignUpArguments({required this.roleId, required this.roleName});
}
class NotificationArguments {
  final int roleId;
  final String roleName;

  NotificationArguments({required this.roleId, required this.roleName});
}
class TaskArguments {
  final int roleId;
  final String roleName;

  TaskArguments({required this.roleId, required this.roleName});
}
class SalesOverviewArguments {
  final int roleId;
  final String roleName;

  SalesOverviewArguments({required this.roleId, required this.roleName});
}
class SalesleadsArguments {
  final int roleId;
  final String roleName;

  SalesleadsArguments({required this.roleId, required this.roleName});
}
class SalesfollowupArguments {
  final int roleId;
  final String roleName;

  SalesfollowupArguments({required this.roleId, required this.roleName});
}
class SalesmeetingArguments {
  final int roleId;
  final String roleName;

  SalesmeetingArguments({required this.roleId, required this.roleName});
}
class SalesquotationArguments {
  final int roleId;
  final String roleName;

  SalesquotationArguments({required this.roleId, required this.roleName});
}