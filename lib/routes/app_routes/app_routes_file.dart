import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:imusa04_landlord_app/screens/BaseScreen/NavBar/nav_bar.dart';
import '../../screens/BaseScreen/AuthScreen/CreateNewPasswordScreen/create_new_password_screen.dart';
import '../../screens/BaseScreen/AuthScreen/ForgotPasswordScreen/forgot_password_screen.dart';
import '../../screens/BaseScreen/AuthScreen/OtpVerificationScreen/otp_verification_screen.dart';
import '../../screens/BaseScreen/AuthScreen/PasswordUpdatedScreen/password_updated_screen.dart';
import '../../screens/BaseScreen/AuthScreen/SignInScreen/sign_in_screen.dart';
import '../../screens/BaseScreen/AuthScreen/SignUpScreen/sign_up_screen.dart';
import '../../screens/BaseScreen/OnboardScreen/onboarding_screen.dart';
import '../../screens/BaseScreen/SplashScreen/splash_screen.dart';
import 'app_routes.dart';

List<GetPage> appRouteFile = <GetPage>[


  ////////////Auth Part////////////
  GetPage(name: AppRoutes.splashScreen,        page: () => const SplashScreen()),
  GetPage(name: AppRoutes.navBar,        page: () => const NavBar()),
  GetPage(name: AppRoutes.onboardingScreen,    page: () => const OnboardingScreen()),
  GetPage(name: AppRoutes.signInScreen, page: () => const SignInScreen()),
  GetPage(name: AppRoutes.forgotPasswordScreen,     page: () => const ForgotPasswordScreen()),
  GetPage(name: AppRoutes.otpVerificationScreen,    page: () => const OtpVerificationScreen()),
  GetPage(name: AppRoutes.createNewPasswordScreen,  page: () => const CreateNewPasswordScreen()),
  GetPage(name: AppRoutes.passwordUpdatedScreen,    page: () => const PasswordUpdatedScreen()),
  GetPage(name: AppRoutes.signUpScreen,             page: () => const SignUpScreen()),
];