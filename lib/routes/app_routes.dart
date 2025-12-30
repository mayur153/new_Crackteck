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

  // salesperson screens
    static const String SalespersonDashboard = '/salesperson_dashboard';
    static const String NotificationScreen = '/salesperson_notification';
    static const String TaskScreen = '/task';
    static const String SalesOverviewScreen = '/sales_overview';
    static const String SalesPersonLeadsScreen = '/sales_leads';
    static const String SalesPersonFollowUpScreen = '/sale_followup';
    static const String SalesPersonMeetingScreen = '/sale_meeting';
    static const String SalesPersonQuotationScreen = '/sale_quatation';
    static const String SalesPersonMoreScreen = '/sale_profile';
    static const String PrivacyPolicyScreen = '/sale_policy';
    static const String SalesPersonPersonalInfoScreen = '/sale_personal_info';
    static const String SalesPersonAttendanceScreen = '/sale_personal_attendance';
    static const String NewLeadScreen = '/sale_new_lead';
    static const String NewFollowUpScreen = '/sale_new_follow-up';
    static const String NewMeetingScreen = '/sale_new_meeting';
    static const String NewQuotationScreen = '/sale_new_quotation';
    static const String ProductScreen = '/sale_product_screen';
    static const String EditLeadScreen = '/sale_edit_lead';
    static const String EditFollowUpScreen = '/sale_edit_followup';
    static const String EditMeetingScreen = '/sale_edit_meeting';
    static const String EditQuotationScreen = '/sale_edit_quotation';

  //delivery man screens
    static const String DeliveryPersonHomeTab = '/delivery_man';
    static const String ProductToBeDeliveredScreen = '/delivery_product';
    static const String DeliveryDashboard = '/delivery_dashboard';
    static const String DeliveryNotificationScreen = '/delivery_notification';
    static const String DeliverypickupparcelScreen = '/delivery_pickup_parcel';
    static const String DeliveryOtpScreen = '/delivery_otp_screen';
    static const String DeliveryOtpVerificationScreen = '/delivery_otp_verification';
    static const String DeliveryDoneScreen = '/delivery_done';
    static const String DeliveryDetailScreen = '/delivery_detail';

    static const String PlaceholderScreen = '/placeholder';


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
  class SalespersonArguments {
    final int roleId;
    final String roleName;

    SalespersonArguments({required this.roleId, required this.roleName});
  }
  class SalespolicyArguments {
    final int roleId;
    final String roleName;

    SalespolicyArguments({required this.roleId, required this.roleName});
  }
  class SalespersonalinfoArguments {
    final int roleId;
    final String roleName;

    SalespersonalinfoArguments({required this.roleId, required this.roleName});
  }
  class SalesattendanceArguments {
    final int roleId;
    final String roleName;

    SalesattendanceArguments({required this.roleId, required this.roleName});
  }
  class SalesnewleadArguments {
    final int roleId;
    final String roleName;

    SalesnewleadArguments({required this.roleId, required this.roleName});
  }
  class SalesnewfollowupArguments {
    final int roleId;
    final String roleName;

    SalesnewfollowupArguments({required this.roleId, required this.roleName});
  }
  class SalesnewmeetingArguments {
    final int roleId;
    final String roleName;

    SalesnewmeetingArguments({required this.roleId, required this.roleName});
  }
  class SalesnewquotationArguments {
    final int roleId;
    final String roleName;

    SalesnewquotationArguments({required this.roleId, required this.roleName});
  }
  class SalesproductArguments {
    final int roleId;
    final String roleName;

    SalesproductArguments({required this.roleId, required this.roleName});
  }
  class SaleseditleadArguments {
    final int roleId;
    final String roleName;

    SaleseditleadArguments({required this.roleId, required this.roleName});
  }
  class SaleseditmeetingArguments {
    final int roleId;
    final String roleName;

    SaleseditmeetingArguments({required this.roleId, required this.roleName});
  }
  class SaleseditfollowupArguments {
    final int roleId;
    final String roleName;

    SaleseditfollowupArguments({required this.roleId, required this.roleName});
  }
  class SaleseditquotationArguments {
    final int roleId;
    final String roleName;

    SaleseditquotationArguments({required this.roleId, required this.roleName});
  }
  class deliveryhomeArguments {
    final int roleId;
    final String roleName;

    deliveryhomeArguments({required this.roleId, required this.roleName});
  }
  class deliveryproducttobedeliveredArguments {
    final int roleId;
    final String roleName;
    final String orderId;

    deliveryproducttobedeliveredArguments({required this.roleId, required this.roleName, required this.orderId});
  }
  class deliverydasboardArguments {
    final int roleId;
    final String roleName;
    final int initialIndex;

    deliverydasboardArguments({required this.roleId, required this.roleName, this.initialIndex = 0});
  }
  class deliverynotificationArguments {
    final int roleId;
    final String roleName;

    deliverynotificationArguments({required this.roleId, required this.roleName});
  }
  class deliverypickupparcelArguments {
    final int roleId;
    final String roleName;
    final String orderId;

    deliverypickupparcelArguments({required this.roleId, required this.roleName, required this.orderId});
  }
  class deliveryotpArguments {
    final int roleId;
    final String roleName;
    final String orderId;

    deliveryotpArguments({required this.roleId, required this.roleName, required this.orderId});
  }
  class PlaceholderArguments {
    final int roleId;
    final String roleName;

    PlaceholderArguments({required this.roleId, required this.roleName});
  }
  class deliveryotpverificationArguments {
    final int roleId;
    final String roleName;
    final String orderId;

    deliveryotpverificationArguments({required this.roleId, required this.roleName, required this.orderId});
  }
  class deliverydoneArguments {
    final int roleId;
    final String roleName;

    deliverydoneArguments({required this.roleId, required this.roleName});
  }
  class deliverydetailArguments {
    final int roleId;
    final String roleName;

    deliverydetailArguments({required this.roleId, required this.roleName});
  }