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

class SignUpArguments {
  final int roleId;
  final String roleName;

  SignUpArguments({required this.roleId, required this.roleName});
}
