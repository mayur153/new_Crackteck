import 'package:flutter/material.dart';
import '../screens/Delivery_person/delivery_dashboard.dart';
import '../screens/Delivery_person/delivery_done_screen.dart';
import '../screens/Delivery_person/delivery_home_tab.dart';
import '../screens/Delivery_person/delivery_notification.dart';
import '../screens/Delivery_person/delivery_detail_screen.dart';
import '../screens/Delivery_person/delivery_privacy_policy.dart';
import '../screens/Delivery_person/delivery_terms_condition.dart';
import '../screens/Delivery_person/map_with-start.dart';
import '../screens/Delivery_person/product_to_be_deliveried_screen.dart';
import '../screens/Delivery_person/delivery_otp_screen.dart';
import '../screens/Delivery_person/delivery_otp_verification_screen.dart';
import '../screens/Delivery_person/delivery_profile_tab.dart';
import '../screens/Delivery_person/delivery_person_documents.dart';
import '../screens/Delivery_person/delivery_edit_adhar_card.dart';
import '../screens/Delivery_person/delivery_edit_pan_card.dart';
import '../screens/Delivery_person/delivery_edit_License_card.dart';
import '../screens/Delivery_person/delivery_vehilcle_details.dart';
import '../screens/Delivery_person/delivery_person_attendance.dart';
import '../screens/Delivery_person/delivery_feedback.dart';
import '../screens/Delivery_person/delivery_track_order.dart';

import '../screens/Field_executive/field_excutive_attendance.dart';
import '../screens/Field_executive/field_executive_add_product.dart';
import '../screens/Field_executive/field_executive_all_products_screen.dart';
import '../screens/Field_executive/field_executive_dashboard.dart';
import '../screens/Field_executive/field_executive_installation_detail_screen.dart';
import '../screens/Field_executive/field_executive_map_tracking_screen.dart';
import '../screens/Field_executive/field_executive_notification.dart';
import '../screens/Field_executive/field_executive_otp_verification_screen.dart';
import '../screens/Field_executive/field_executive_personal_info.dart';
import '../screens/Field_executive/field_executive_pickup_product.dart';
import '../screens/Field_executive/field_executive_product_detail.dart' as product_detail;
import '../screens/Field_executive/field_executive_product_item_detail_screen.dart';
import '../screens/Field_executive/field_executive_repair_request_part.dart';
import '../screens/Field_executive/field_executive_stock_in_hand.dart';
import '../screens/Field_executive/field_executive_product_list_to_add_more.dart' as product_list;
import '../screens/Field_executive/field_executive_detail_requested_product.dart' as detail_requested;
import '../screens/Field_executive/field_executive_product_payment.dart';
import '../screens/Field_executive/field_executive_cash_in_hand.dart';
import '../screens/Field_executive/field_executive_payment_receipts.dart';
import '../screens/Field_executive/field_executive_payment_done.dart';
import '../screens/Field_executive/field_executive_upload_before_images_screen.dart';
import '../screens/Field_executive/field_executive_work_call.dart';
import '../screens/Field_executive/field_executive_write_report_screen.dart';
import '../screens/Field_executive/field_executive_case_transfer_screen.dart';
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
import '../widgets/placeholder.dart';
import 'app_routes.dart' hide DashboardScreen;
import '../screens/Field_executive/field_executive_profile_screen.dart';


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
        final args = settings.arguments as SalespersonArguments?;
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
              // route SalesPersonMoreScreen now opens the combined profile screen requested
              CombinedProfileScreen(roleId: args.roleId, roleName: args.roleName),
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
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              ProductToBeDeliveredScreen(
                roleId: args.roleId,
                roleName: args.roleName,
                orderId: args.orderId,
              ),
          settings: settings,
        );

        case AppRoutes.DeliveryDashboard:
        final args = settings.arguments as deliverydasboardArguments?;
        if (args == null) {
          return _errorRoute('Login arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              DeliveryDashboard(
                roleId: args.roleId,
                roleName: args.roleName,
                initialIndex: args.initialIndex,
              ),
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
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              DeliverypickupparcelScreen(
                roleId: args.roleId,
                roleName: args.roleName,
                orderId: args.orderId,
              ),
          settings: settings,
        );

      case AppRoutes.DeliveryOtpScreen:
        final args = settings.arguments as deliveryotpArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              DeliveryOtpScreen(
                roleId: args.roleId,
                roleName: args.roleName,
                orderId: args.orderId,
              ),
          settings: settings,
        );

      case AppRoutes.DeliveryOtpVerificationScreen:
        final args = settings.arguments as deliveryotpverificationArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              DeliveryOtpVerificationScreen(
                roleId: args.roleId,
                roleName: args.roleName,
                orderId: args.orderId,
              ),
          settings: settings,
        );

      case AppRoutes.DeliveryDoneScreen:
        final args = settings.arguments as deliverydoneArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              DeliveryDoneScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.DeliveryDetailScreen:
        final args = settings.arguments as deliverydetailArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              DeliveryDetailsScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.PlaceholderScreen:
        final args = settings.arguments as PlaceholderArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              ComingSoonScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

        case AppRoutes.DeliveryPrivacyPolicyScreen:
        final args = settings.arguments as deliverypolicyArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              DeliveryPrivacyPolicyScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

        case AppRoutes.DeliveryTermsConditionScreen:
        final args = settings.arguments as deliverytermsArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              DeliveryTermsConditionScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.DeliveryProfileScreen:
        final args = settings.arguments as deliveryprofileArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              DeliveryProfileScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.DeliveryDocumentsScreen:
        final args = settings.arguments as deliverydocumentsArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) => const DocumentsScreen(),
          settings: settings,
        );

      case AppRoutes.DeliveryAadhaarEditScreen:
        final args = settings.arguments as deliveryaadhaareditArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) => const AadhaarEditScreen(),
          settings: settings,
        );

      case AppRoutes.DeliveryPancardEditScreen:
        final args = settings.arguments as deliverypancardeditArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) => const PancardEditScreen(),
          settings: settings,
        );

      case AppRoutes.DeliveryLicenseEditScreen:
        final args = settings.arguments as deliverylicenseeditArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) => const LicenseEditScreen(),
          settings: settings,
        );

      case AppRoutes.DeliveryVehicleDetailsScreen:
        final args = settings.arguments as deliveryvehicledetailsArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) => const VehicleDetailsScreen(),
          settings: settings,
        );

      case AppRoutes.DeliveryAttendanceScreen:
        final args = settings.arguments as deliveryattendanceArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              DeliveryPersonAttendanceScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.DeliveryFeedbackScreen:
        final args = settings.arguments as deliveryfeedbackArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) => const FeedbackScreen(),
          settings: settings,
        );

      case AppRoutes.DeliveryTrackOrderScreen:
        final args = settings.arguments as deliverytrackorderArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              TotalDeliveryScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

        // Field Executive cases
      case AppRoutes.FieldExecutiveDashboard:
        final args = settings.arguments as fieldexecutivedashboardArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              FieldExecutiveDashboard(
                roleId: args.roleId,
                roleName: args.roleName,
                initialIndex: args.initialIndex,
              ),
          settings: settings,
        );

      case AppRoutes.FieldExecutiveNotificationScreen:
        final args = settings.arguments as fieldexecutivenotificationArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              EnigneerNotificationScreen(
                // roleId: args.roleId,
                // roleName: args.roleName,
              ),
          settings: settings,
        );

        case AppRoutes.FieldExecutiveStockInHandScreen:
        final args = settings.arguments as fieldexecutivestockinhandArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              StockInHandScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

        case AppRoutes.FieldExecutiveProductDetailScreen:
        final args = settings.arguments as fieldexecutiveproductdetailArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              product_detail.ProductDetailScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.FieldExecutiveAddProductScreen:
        final args = settings.arguments as fieldexecutiveaddproductArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              AddProductScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.FieldExecutiveProductListToAddMoreScreen:
        final args = settings.arguments as fieldexecutiveproductlisttoaddmoreArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              product_list.ProductListScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.FieldExecutiveRequestedProductDetailScreen:
        final args = settings.arguments as fieldexecutiverequestedproductlistArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              detail_requested.ProductRequestedDetailScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.FieldExecutiveProductPaymentScreen:
        final args = settings.arguments as fieldexecutiveproductpaymentArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              FieldExecutiveProductPaymentScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.FieldExecutiveCashInHandScreen:
        final args = settings.arguments as fieldexecutivecashinhandArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              FieldExecutiveCashInHandScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.FieldExecutivePaymentReceiptsScreen:
        final args = settings.arguments as fieldexecutivepaymentreceiptsArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              FieldExecutivePaymentReceiptsScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.FieldExecutivePaymentDoneScreen:
        final args = settings.arguments as fieldexecutivepaymentdoneArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              FieldExecutivePaymentDoneScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.FieldExecutiveWorkCallScreen:
        final args = settings.arguments as fieldexecutiveworkcallArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              FieldExecutiveWorkCallScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );


      case AppRoutes.FieldExecutiveOtpVerificationScreen:
        final args = settings.arguments as fieldexecutiveotpverificationArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              FieldExecutiveOtpVerificationScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.FieldExecutiveAllProductsScreen:
        final args = settings.arguments as fieldexecutiveallproductsArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              FieldExecutiveAllProductsScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.FieldExecutiveProductItemDetailScreen:
        final args = settings.arguments as fieldexecutiveproductitemdetailArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              FieldExecutiveProductItemDetailScreen(
                roleId: args.roleId,
                roleName: args.roleName,
                title: args.title,
                serviceId: args.serviceId,
                location: args.location,
                priority: args.priority,
              ),
          settings: settings,
        );

      case AppRoutes.FieldExecutiveMapTrackingScreen:
        final args = settings.arguments as fieldexecutivemaptrackingArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              FieldExecutiveMapTrackingScreen(
                roleId: args.roleId,
                roleName: args.roleName,
                serviceId: args.serviceId,
              ),
          settings: settings,
        );

      case AppRoutes.FieldExecutiveUploadBeforeImagesScreen:
        final args = settings.arguments as fieldexecutiveuploadbeforeimagesArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              FieldExecutiveUploadBeforeImagesScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.FieldExecutiveInstallationDetailScreen:
        final args = settings.arguments as fieldexecutiveinstallationdetailArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              FieldExecutiveInstallationDetailScreen(
                roleId: args.roleId,
                roleName: args.roleName,
                title: args.title,
                serviceId: args.serviceId,
                location: args.location,
                priority: args.priority,
                // new: pass jobType so the screen can render differently for repairs
                jobType: args.jobType,
              ),
          settings: settings,
        );

      case AppRoutes.FieldExecutiveWriteReportScreen:
        final args = settings.arguments as fieldexecutivewritereportArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) =>
              FieldExecutiveWriteReportScreen(
                roleId: args.roleId,
                roleName: args.roleName,
              ),
          settings: settings,
        );

      case AppRoutes.FieldExecutiveCaseTransferScreen:
        final args = settings.arguments as fieldexecutivecasetransferArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) => FieldExecutiveCaseTransferScreen(
            roleId: args.roleId,
            roleName: args.roleName,
          ),
          settings: settings,
        );

      case AppRoutes.FieldExecutivePersonalInfo:
        final args = settings.arguments as fieldexecutivePersonalInfoArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) => FieldExecutivePersonalInfo(
            roleId: args.roleId,
            roleName: args.roleName,
          ),
          settings: settings,
        );

      case AppRoutes.field_executive_attendance:
        final args = settings.arguments as fieldexecutiveattendanceArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) => field_executive_attendance(
            roleId: args.roleId,
            roleName: args.roleName,
          ),
          settings: settings,
        );

      case AppRoutes.PickupMaterialsScreen:
        final args = settings.arguments as fieldexecutivePickupMaterialArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) => PickupMaterialsScreen(
            roleId: args.roleId,
            roleName: args.roleName,
          ),
          settings: settings,
        );

      case AppRoutes.RepairRequestScreen:
        final args = settings.arguments as fieldexecutiveRepairRequestArguments?;
        if (args == null) {
          return _errorRoute('Arguments missing');
        }
        return MaterialPageRoute(
          builder: (_) => RepairRequestScreen(
            roleId: args.roleId,
            roleName: args.roleName,
          ),
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
