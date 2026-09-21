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
import '../../screens/UserScreen/LandlordAllScreen/Announcement/announcement_detail_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/Announcement/announcement_list_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/Announcement/controller/announcement_controller.dart';
import '../../screens/UserScreen/LandlordAllScreen/Announcement/create_announcement_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/Maintenance/assign_contractor_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/Maintenance/controller/maintenance_controller.dart';
import '../../screens/UserScreen/LandlordAllScreen/Maintenance/log_issue_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/Maintenance/maintenance_issue_detail_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/Maintenance/maintenance_list_screen.dart';
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
    binding: BindingsBuilder(() => Get.lazyPut(() => AnnouncementController(), fenix: true)),
  ),
  GetPage(name: AppRoutes.announcementDetailScreen, page: () => const AnnouncementDetailScreen()),
  GetPage(name: AppRoutes.createAnnouncementScreen, page: () => const CreateAnnouncementScreen()),
  GetPage(
    name: AppRoutes.maintenanceListScreen,
    page: () => const MaintenanceListScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(() => MaintenanceController(), fenix: true)),
  ),
  GetPage(name: AppRoutes.maintenanceIssueDetailScreen, page: () => const MaintenanceIssueDetailScreen()),
  GetPage(name: AppRoutes.logIssueScreen, page: () => const LogIssueScreen()),
  GetPage(name: AppRoutes.assignContractorScreen, page: () => const AssignContractorScreen()),
];
