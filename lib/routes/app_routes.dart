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
    static const String DeliveryPrivacyPolicyScreen = '/delivery_privacy_policy';
    static const String DeliveryTermsConditionScreen = '/delivery_terms_condition';
    static const String DeliveryProfileScreen = '/delivery_profile';
    static const String DeliveryDocumentsScreen = '/delivery_documents';
    static const String DeliveryAadhaarEditScreen = '/delivery_aadhaar_edit';
    static const String DeliveryPancardEditScreen = '/delivery_pancard_edit';
    static const String DeliveryLicenseEditScreen = '/delivery_license_edit';
    static const String DeliveryVehicleDetailsScreen = '/delivery_vehicle_details';
    static const String DeliveryAttendanceScreen = '/delivery_attendance';
    static const String DeliveryFeedbackScreen = '/delivery_feedback';
    static const String DeliveryTrackOrderScreen = '/delivery_track_order';

    // field executive screens
    static const String FieldExecutiveDashboard = '/field_executive_dashboard';
    static const String FieldExecutiveNotificationScreen = '/field_executive_notification';
    static const String FieldExecutiveStockInHandScreen = '/field_executive_stock_in_hand';
    static const String FieldExecutiveProductDetailScreen = '/field_executive_product_detail';
    static const String FieldExecutiveAddProductScreen = '/field_executive_add_product';
    static const String FieldExecutiveProductListToAddMoreScreen = '/field_executive_product_list';
    static const String FieldExecutiveRequestedProductDetailScreen = '/field_executive_requested_product_detail';
    static const String FieldExecutiveProductPaymentScreen = '/field_executive_product_payment';
    static const String FieldExecutiveCashInHandScreen = '/field_executive_cash_in_hand';
    static const String FieldExecutivePaymentReceiptsScreen = '/field_executive_payment_receipts';
    static const String FieldExecutivePaymentDoneScreen = '/field_executive_payment_done';
    static const String FieldExecutiveWorkCallScreen = '/field_executive_work_call';
    static const String FieldExecutiveInstallationDetailScreen = '/field_executive_installation_detail';
    static const String FieldExecutiveOtpVerificationScreen = '/field_executive_otp_verification';
    static const String FieldExecutiveAllProductsScreen = '/field_executive_all_products';
    static const String FieldExecutiveProductItemDetailScreen = '/field_executive_product_item_detail';
    static const String FieldExecutiveMapTrackingScreen = '/field_executive_map_tracking';
    static const String FieldExecutiveUploadBeforeImagesScreen = '/field_executive_upload_before_images';
    static const String FieldExecutiveWriteReportScreen = '/field_executive_write_report';
    static const String FieldExecutiveCaseTransferScreen = '/field_executive_case_transfer';
    static const String FieldExecutivePersonalInfo = '/field_executive_personal_info';
    static const String field_executive_attendance = '/field_executive_attendance';
    static const String PickupMaterialsScreen = '/field_executive_pickup_material';
    static const String RepairRequestScreen = '/field_executive_repair_request';
    static const String PaymentsScreen = '/field_executive_payments';
    static const String WorksScreen = '/field_executive_works';

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
    final String roleName;    final String orderId;

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
  class deliverypolicyArguments {
    final int roleId;
    final String roleName;

    deliverypolicyArguments({required this.roleId, required this.roleName});
  }
  class deliverytermsArguments {
    final int roleId;
    final String roleName;

    deliverytermsArguments({required this.roleId, required this.roleName});
  }

  class deliveryprofileArguments {
    final int roleId;
    final String roleName;

    deliveryprofileArguments({required this.roleId, required this.roleName});
  }

  class deliverydocumentsArguments {
    final int roleId;
    final String roleName;

    deliverydocumentsArguments({required this.roleId, required this.roleName});
  }

  class deliveryaadhaareditArguments {
    final int roleId;
    final String roleName;

    deliveryaadhaareditArguments({required this.roleId, required this.roleName});
  }

  class deliverypancardeditArguments {
    final int roleId;
    final String roleName;

    deliverypancardeditArguments({required this.roleId, required this.roleName});
  }

  class deliverylicenseeditArguments {
    final int roleId;
    final String roleName;

    deliverylicenseeditArguments({required this.roleId, required this.roleName});
  }

  class deliveryvehicledetailsArguments {
    final int roleId;
    final String roleName;

    deliveryvehicledetailsArguments({required this.roleId, required this.roleName});
  }

  class deliveryattendanceArguments {
    final int roleId;
    final String roleName;

    deliveryattendanceArguments({required this.roleId, required this.roleName});
  }

  class deliveryfeedbackArguments {
    final int roleId;
    final String roleName;

    deliveryfeedbackArguments({required this.roleId, required this.roleName});
  }

  class deliverytrackorderArguments {
    final int roleId;
    final String roleName;

    deliverytrackorderArguments({required this.roleId, required this.roleName});
  }

  class fieldexecutivedashboardArguments {
    final int roleId;
    final String roleName;
    final int initialIndex;

    fieldexecutivedashboardArguments({required this.roleId, required this.roleName, this.initialIndex = 0});
  }
  class fieldexecutivenotificationArguments {
    final int roleId;
    final String roleName;

    fieldexecutivenotificationArguments({required this.roleId, required this.roleName});
  }
  class fieldexecutivestockinhandArguments {
    final int roleId;
    final String roleName;

    fieldexecutivestockinhandArguments({required this.roleId, required this.roleName});
  }
  class fieldexecutiveproductdetailArguments {
    final int roleId;
    final String roleName;

    fieldexecutiveproductdetailArguments({required this.roleId, required this.roleName});
  }
  class fieldexecutiveaddproductArguments {
    final int roleId;
    final String roleName;

    fieldexecutiveaddproductArguments({required this.roleId, required this.roleName});
  }
  class fieldexecutiverequestedproductlistArguments {
    final int roleId;
    final String roleName;

    fieldexecutiverequestedproductlistArguments({required this.roleId, required this.roleName});
  }

  class fieldexecutiveproductlisttoaddmoreArguments {
    final int roleId;
    final String roleName;

    fieldexecutiveproductlisttoaddmoreArguments({required this.roleId, required this.roleName});
  }

  class fieldexecutiveproductpaymentArguments {
    final int roleId;
    final String roleName;

    fieldexecutiveproductpaymentArguments({required this.roleId, required this.roleName});
  }

  class fieldexecutivecashinhandArguments {
    final int roleId;
    final String roleName;

    fieldexecutivecashinhandArguments({required this.roleId, required this.roleName});
  }

  class fieldexecutivepaymentreceiptsArguments {
    final int roleId;
    final String roleName;

    fieldexecutivepaymentreceiptsArguments({required this.roleId, required this.roleName});
  }

  class fieldexecutivepaymentdoneArguments {
    final int roleId;
    final String roleName;

    fieldexecutivepaymentdoneArguments({required this.roleId, required this.roleName});
  }

  class fieldexecutiveworkcallArguments {
    final int roleId;
    final String roleName;

    fieldexecutiveworkcallArguments({required this.roleId, required this.roleName});
  }

  class fieldexecutiveinstallationdetailArguments {
    final int roleId;
    final String roleName;
    final String title;
    final String serviceId;
    final String location;
    final String priority;
    final String jobType; // 'installations' | 'repairs' | 'amc'

    fieldexecutiveinstallationdetailArguments({
      required this.roleId,
      required this.roleName,
      required this.title,
      required this.serviceId,
      required this.location,
      required this.priority,
      required this.jobType,
    });
  }

  class fieldexecutiveotpverificationArguments {
    final int roleId;
    final String roleName;

    fieldexecutiveotpverificationArguments({required this.roleId, required this.roleName});
  }

  class fieldexecutiveallproductsArguments {
    final int roleId;
    final String roleName;

    fieldexecutiveallproductsArguments({required this.roleId, required this.roleName});
  }

  class fieldexecutiveproductitemdetailArguments {
    final int roleId;
    final String roleName;
    final String title;
    final String serviceId;
    final String location;
    final String priority;

    fieldexecutiveproductitemdetailArguments({
      required this.roleId,
      required this.roleName,
      required this.title,
      required this.serviceId,
      required this.location,
      required this.priority,
    });
  }

  class fieldexecutivemaptrackingArguments {
    final int roleId;
    final String roleName;    final String serviceId;

    fieldexecutivemaptrackingArguments({
      required this.roleId,
      required this.roleName,
      required this.serviceId,
    });
  }

  class fieldexecutiveuploadbeforeimagesArguments {
    final int roleId;
    final String roleName;

    fieldexecutiveuploadbeforeimagesArguments({required this.roleId, required this.roleName});
  }

  class fieldexecutivewritereportArguments {
    final int roleId;
    final String roleName;

    fieldexecutivewritereportArguments({required this.roleId, required this.roleName});
  }

  class fieldexecutivecasetransferArguments {
    final int roleId;
    final String roleName;

    fieldexecutivecasetransferArguments({required this.roleId, required this.roleName});
  }


  class fieldexecutivePersonalInfoArguments {
    final int roleId;
    final String roleName;

    fieldexecutivePersonalInfoArguments({required this.roleId, required this.roleName});
  }


  class fieldexecutiveattendanceArguments {
    final int roleId;
    final String roleName;

    fieldexecutiveattendanceArguments({required this.roleId, required this.roleName});
  }


  class fieldexecutivePickupMaterialArguments {
    final int roleId;
    final String roleName;

    fieldexecutivePickupMaterialArguments({required this.roleId, required this.roleName});
  }


  class fieldexecutiveRepairRequestArguments {
    final int roleId;
    final String roleName;

    fieldexecutiveRepairRequestArguments({required this.roleId, required this.roleName});
  }


  class fieldexecutivePaymentsScreenArguments {
    final int roleId;
    final String roleName;

    fieldexecutivePaymentsScreenArguments({required this.roleId, required this.roleName});
  }

  class fieldexecutiveWorksScreenArguments {
    final int roleId;
    final String roleName;

    fieldexecutiveWorksScreenArguments({required this.roleId, required this.roleName});
  }
