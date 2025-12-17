/// API endpoint constants
class ApiConstants {
  ApiConstants._(); // Private constructor to prevent instantiation

  // Base URL Configuration
  //
  // IMPORTANT: Choose the correct base URL based on your testing environment:
  //
  // 1. Android Emulator: Use '10.0.2.2' to access host machine's localhost
  //    static const String baseUrl = 'http://10.0.2.2:8000/api';
  //
  // 2. Physical Android Device: Use your PC's local network IP address
  //    Find your IP with: ipconfig (Windows) or ifconfig (Mac/Linux)
  //    Example: static const String baseUrl = 'http://192.168.1.100:8000/api';
  //
  // 3. iOS Simulator: Use 'localhost' or '127.0.0.1'
  //    static const String baseUrl = 'http://127.0.0.1:8000/api';
  //
  // 4. Web/Desktop: Use 'localhost' or '127.0.0.1'
  //    static const String baseUrl = 'http://127.0.0.1:8000/api';

  // Current Configuration: Android Emulator
  static const String baseUrl = 'https://crackteck.co.in/api/v1';

  // Authentication Endpoints
  static const String login = '$baseUrl/send-otp';
  static const String verifyOtp = '$baseUrl/verify-otp';
  static const String refreshToken = '$baseUrl/refresh-token';
  static const String signup = '$baseUrl/signup';
  static const String logout = '$baseUrl/logout';
  static const String dashboard = '$baseUrl/dashboard';

  // Request Timeout
  static const Duration requestTimeout = Duration(seconds: 30);

  // Country Code
  static const String defaultCountryCode = '+91';
}
