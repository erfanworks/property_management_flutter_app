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
import '../../screens/UserScreen/LandlordAllScreen/DrawerAllScreen/Contractors/contractor_detail_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/DrawerAllScreen/Contractors/contractor_reviews_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/DrawerAllScreen/Contractors/contractors_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/DrawerAllScreen/Contractors/controller/contractors_controller.dart';
import '../../screens/UserScreen/LandlordAllScreen/DrawerAllScreen/Contractors/invite_contractor_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/DrawerAllScreen/SmartReminders/add_smart_reminder_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/DrawerAllScreen/SmartReminders/controller/smart_reminders_controller.dart';
import '../../screens/UserScreen/LandlordAllScreen/DrawerAllScreen/SmartReminders/smart_reminder_detail_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/DrawerAllScreen/SmartReminders/smart_reminders_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/DrawerAllScreen/TenantsDirectory/controller/tenants_directory_controller.dart';
import '../../screens/UserScreen/LandlordAllScreen/DrawerAllScreen/TenantsDirectory/tenants_directory_screen.dart';
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
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/InviteTenant/invite_tenant_step1_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/InviteTenant/invite_tenant_step2_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/InviteTenant/invite_tenant_step3_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/appliances_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/certificate_list_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/compliance_hub_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/conduct_inspection_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/controller/house_rules_controller.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/controller/inspections_controller.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/controller/inventory_controller.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/edit_house_rules_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/gas_certificate_detail_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/house_rules_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/inspection_report_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/inspections_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/inventory_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/other_documents_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/room_items_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/safety_alarms_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Tenant/lease_agreement_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Tenant/nid_document_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Tenant/tenant_add_note_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Tenant/tenant_deposit_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Tenant/tenant_documents_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Tenant/tenant_edit_keys_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Tenant/tenant_keys_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Tenant/tenant_notes_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Tenant/tenant_payments_history_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/UnitDetail/add_unit_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/UnitDetail/controller/unit_detail_controller.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/UnitDetail/key_set_form_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/UnitDetail/keys_access_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/UnitDetail/unit_detail_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/controller/property_detail_controller.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Info/floor_plans_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/property_detail_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Info/property_photos_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Info/service_detail_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Info/service_edit_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Info/services_meters_screen.dart';
import '../../screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Tenant/tenant_details_screen.dart';
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
  GetPage(name: AppRoutes.complianceHubScreen, page: () => const ComplianceHubScreen()),
  GetPage(name: AppRoutes.certificateListScreen, page: () => const CertificateListScreen()),
  GetPage(name: AppRoutes.gasCertificateDetailScreen, page: () => const GasCertificateDetailScreen()),
  GetPage(name: AppRoutes.otherDocumentsScreen, page: () => const OtherDocumentsScreen()),
  GetPage(name: AppRoutes.safetyAlarmsScreen, page: () => const SafetyAlarmsScreen()),
  GetPage(name: AppRoutes.appliancesScreen, page: () => const AppliancesScreen()),
  GetPage(name: AppRoutes.inspectionsScreen, page: () => const InspectionsScreen()),
  GetPage(name: AppRoutes.houseRulesScreen, page: () => const HouseRulesScreen()),
  // app_routes_file.dart
  GetPage(name: AppRoutes.nidDocumentScreen, page: () => const NidDocumentScreen()),
  GetPage(name: AppRoutes.leaseAgreementScreen, page: () => const LeaseAgreementScreen()),
  GetPage(name: AppRoutes.tenantDepositScreen, page: () => const TenantDepositScreen()),
  GetPage(name: AppRoutes.tenantPaymentsHistoryScreen, page: () => const TenantPaymentsHistoryScreen()),
  GetPage(name: AppRoutes.tenantKeysScreen, page: () => const TenantKeysScreen()),
  GetPage(name: AppRoutes.tenantEditKeysScreen, page: () => const TenantEditKeysScreen()),
  GetPage(name: AppRoutes.tenantNotesScreen, page: () => const TenantNotesScreen()),
  GetPage(name: AppRoutes.tenantAddNoteScreen, page: () => const TenantAddNoteScreen()),
  GetPage(name: AppRoutes.tenantDocumentsScreen, page: () => const TenantDocumentsScreen()),
  GetPage(name: AppRoutes.inviteTenantStep1Screen, page: () => const InviteTenantStep1Screen()),
  GetPage(name: AppRoutes.inviteTenantStep2Screen, page: () => const InviteTenantStep2Screen()),
  GetPage(name: AppRoutes.inviteTenantStep3Screen, page: () => const InviteTenantStep3Screen()),
  // app_routes_file.dart
  GetPage(name: AppRoutes.safetyAlarmsScreen, page: () => const SafetyAlarmsScreen()),
  GetPage(name: AppRoutes.appliancesScreen, page: () => const AppliancesScreen()),
  GetPage(
    name: AppRoutes.inspectionsScreen,
    page: () => const InspectionsScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(() => InspectionsController(), fenix: true)),
  ),
  GetPage(name: AppRoutes.conductInspectionScreen, page: () => const ConductInspectionScreen()),
  GetPage(name: AppRoutes.inspectionReportScreen, page: () => const InspectionReportScreen()),
  GetPage(
    name: AppRoutes.houseRulesScreen,
    page: () => const HouseRulesScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(() => HouseRulesController(), fenix: true)),
  ),
  GetPage(name: AppRoutes.editHouseRulesScreen, page: () => const EditHouseRulesScreen()),
  GetPage(
    name: AppRoutes.inventoryScreen,
    page: () => const InventoryScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(() => InventoryController(), fenix: true)),
  ),
  GetPage(name: AppRoutes.roomItemsScreen, page: () => const RoomItemsScreen()),
  // app_routes_file.dar
  GetPage(name: AppRoutes.unitDetailScreen, page: () => const UnitDetailScreen()),
  GetPage(
    name: AppRoutes.addUnitScreen,
    page: () => const AddUnitScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(() => UnitDetailController())),
  ),
  GetPage(name: AppRoutes.keysAccessScreen, page: () => const KeysAccessScreen()),
  GetPage(name: AppRoutes.addKeySetScreen, page: () => const KeySetFormScreen()),
  GetPage(name: AppRoutes.editKeySetScreen, page: () => const KeySetFormScreen()),
  // app_routes_file.dart
  GetPage(
    name: AppRoutes.smartRemindersScreen,
    page: () => const SmartRemindersScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(() => SmartRemindersController(), fenix: true)),
  ),
  GetPage(name: AppRoutes.smartReminderDetailScreen, page: () => const SmartReminderDetailScreen()),
  GetPage(name: AppRoutes.addSmartReminderScreen, page: () => const AddSmartReminderScreen()),
  GetPage(
    name: AppRoutes.tenantsDirectoryScreen,
    page: () => const TenantsDirectoryScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(() => TenantsDirectoryController(), fenix: true)),
  ),
  GetPage(
    name: AppRoutes.contractorsScreen,
    page: () => const ContractorsScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(() => ContractorsController(), fenix: true)),
  ),
  GetPage(name: AppRoutes.inviteContractorScreen, page: () => const InviteContractorScreen()),
  GetPage(name: AppRoutes.contractorDetailScreen, page: () => const ContractorDetailScreen()),
  GetPage(name: AppRoutes.contractorReviewsScreen, page: () => const ContractorReviewsScreen()),
];
