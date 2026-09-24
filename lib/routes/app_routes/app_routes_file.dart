import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:imusa04_landlord_app/screens/BaseScreen/NavBar/nav_bar.dart';
import '../../screens/BaseScreen/AuthScreen/CreateNewPasswordScreen/create_new_password_screen.dart';
import '../../screens/BaseScreen/AuthScreen/ForgotPasswordScreen/forgot_password_screen.dart';
import '../../screens/BaseScreen/AuthScreen/OtpVerificationScreen/otp_verification_screen.dart';
import '../../screens/BaseScreen/AuthScreen/PasswordUpdatedScreen/password_updated_screen.dart';
import '../../screens/BaseScreen/AuthScreen/SignInScreen/sign_in_screen.dart';
import '../../screens/BaseScreen/AuthScreen/SignUpScreen/sign_up_screen.dart';
import '../../screens/BaseScreen/MessagesScreen/ChatDetailScreen/chat_detail_screen.dart';
import '../../screens/BaseScreen/NotificationScreen/controller/notification_controller.dart';
import '../../screens/BaseScreen/NotificationScreen/notification_screen.dart';
import '../../screens/BaseScreen/OnboardScreen/onboarding_screen.dart';
import '../../screens/BaseScreen/RoleSelectScreen/role_select_screen.dart';
import '../../screens/BaseScreen/SplashScreen/splash_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Announcement/announcement_detail_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Announcement/announcement_list_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Announcement/controller/announcement_controller.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Announcement/create_announcement_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Finance/add_charge_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Finance/controller/finance_controller.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Finance/finance_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Finance/payment_record_detail_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Finance/payment_reminder_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Finance/payment_success_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Finance/record_payment_details_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Finance/record_payment_select_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Finance/rent_due_detail_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Finance/transaction_history_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Maintenance/assign_contractor_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Maintenance/controller/maintenance_controller.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Maintenance/log_issue_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Maintenance/maintenance_issue_detail_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/Maintenance/maintenance_list_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/Properties/property_form_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/controller/property_detail_controller.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/floor_plans_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/property_detail_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/property_photos_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/service_detail_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/service_edit_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/services_meters_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/tenant_details_screen.dart';
import '../bindings/authBindings.dart';
import 'app_routes.dart';

List<GetPage> appRouteFile = <GetPage>[
  ////////////Auth Part////////////
  GetPage(name: AppRoutes.splashScreen, page: () => const SplashScreen()),
  GetPage(name: AppRoutes.roleSelectScreen, page: () => RoleSelectScreen()),
  GetPage(
    name: AppRoutes.navBar,
    page: () => NavBar(),
    binding: AuthBindings(),
  ),
  GetPage(
    name: AppRoutes.onboardingScreen,
    page: () => const OnboardingScreen(),
  ),
  GetPage(name: AppRoutes.signInScreen, page: () => const SignInScreen()),
  GetPage(
    name: AppRoutes.forgotPasswordScreen,
    page: () => const ForgotPasswordScreen(),
  ),
  GetPage(
    name: AppRoutes.otpVerificationScreen,
    page: () => const OtpVerificationScreen(),
  ),
  GetPage(
    name: AppRoutes.createNewPasswordScreen,
    page: () => const CreateNewPasswordScreen(),
  ),
  GetPage(
    name: AppRoutes.passwordUpdatedScreen,
    page: () => const PasswordUpdatedScreen(),
  ),
  GetPage(name: AppRoutes.signUpScreen, page: () => const SignUpScreen()),
  GetPage(
    name: AppRoutes.chatDetailScreen,
    page: () => const ChatDetailScreen(),
  ),
  GetPage(
    name: AppRoutes.notificationScreen,
    page: () => const NotificationScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(() => NotificationController())),
  ),
  // app_routes_file.dart — GetPage list e add koro
  GetPage(
    name: AppRoutes.announcementListScreen,
    page: () => const AnnouncementListScreen(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => AnnouncementController(), fenix: true),
    ),
  ),
  GetPage(
    name: AppRoutes.announcementDetailScreen,
    page: () => const AnnouncementDetailScreen(),
  ),
  GetPage(
    name: AppRoutes.createAnnouncementScreen,
    page: () => const CreateAnnouncementScreen(),
  ),
  GetPage(
    name: AppRoutes.maintenanceListScreen,
    page: () => const MaintenanceListScreen(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => MaintenanceController(), fenix: true),
    ),
  ),
  GetPage(
    name: AppRoutes.maintenanceIssueDetailScreen,
    page: () => const MaintenanceIssueDetailScreen(),
  ),
  GetPage(name: AppRoutes.logIssueScreen, page: () => const LogIssueScreen()),
  GetPage(
    name: AppRoutes.assignContractorScreen,
    page: () => const AssignContractorScreen(),
  ),
  // app_routes_file.dart
  GetPage(
    name: AppRoutes.financeScreen,
    page: () => const FinanceScreen(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => FinanceController(), fenix: true),
    ),
  ),
  GetPage(
    name: AppRoutes.transactionHistoryScreen,
    page: () => const TransactionHistoryScreen(),
  ),
  GetPage(
    name: AppRoutes.paymentRecordDetailScreen,
    page: () => const PaymentRecordDetailScreen(),
  ),
  GetPage(
    name: AppRoutes.rentDueDetailScreen,
    page: () => const RentDueDetailScreen(),
  ),
  GetPage(name: AppRoutes.addChargeScreen, page: () => const AddChargeScreen()),
  GetPage(
    name: AppRoutes.paymentReminderScreen,
    page: () => const PaymentReminderScreen(),
  ),
  GetPage(
    name: AppRoutes.recordPaymentSelectScreen,
    page: () => const RecordPaymentSelectScreen(),
  ),
  GetPage(
    name: AppRoutes.recordPaymentDetailsScreen,
    page: () => const RecordPaymentDetailsScreen(),
  ),
  GetPage(
    name: AppRoutes.paymentSuccessScreen,
    page: () => const PaymentSuccessScreen(),
  ),
  GetPage(
    name: AppRoutes.propertyFormScreen,
    page: () => const PropertyFormScreen(),
  ),
  GetPage(
    name: AppRoutes.propertyDetailScreen,
    page: () => const PropertyDetailScreen(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => PropertyDetailController(), fenix: true),
    ),
  ),
  GetPage(
    name: AppRoutes.tenantDetailsScreen,
    page: () => const TenantDetailsScreen(),
  ),
  // app_routes_file.dart
  GetPage(name: AppRoutes.propertyPhotosScreen, page: () => const PropertyPhotosScreen()),
  GetPage(name: AppRoutes.floorPlansScreen, page: () => const FloorPlansScreen()),
  GetPage(name: AppRoutes.servicesMetersScreen, page: () => const ServicesMetersScreen()),
  GetPage(name: AppRoutes.serviceDetailScreen, page: () => const ServiceDetailScreen()),
  GetPage(name: AppRoutes.serviceEditScreen, page: () => const ServiceEditScreen()),
];
