// lib/screens/UserScreen/LandlordAllScreen/TenantsDirectory/controller/tenants_directory_controller.dart
import 'package:get/get.dart';
import '../../../../../../routes/app_routes/app_routes.dart';
import '../../../PropertiesAllScreen/PropertyDetail/controller/property_detail_controller.dart';
import '../../../PropertiesAllScreen/PropertyDetail/model/property_detail_model.dart';
import '../model/tenant_directory_model.dart';

class TenantsDirectoryController extends GetxController {
  final RxList<TenantDirectoryModel> tenants = <TenantDirectoryModel>[].obs;
  final RxString searchQuery = ''.obs;
  final RxList<String> properties = <String>[].obs;
  final Rx<String?> selectedProperty = Rx<String?>(null);
  final RxList<String> flats = <String>[].obs;
  final Rx<String?> selectedFlat = Rx<String?>(null);

  List<TenantDirectoryModel> get filteredTenants {
    return tenants.where((t) {
      if (selectedProperty.value != null && t.propertyName != selectedProperty.value) return false;
      if (selectedFlat.value != null && t.unitLabel != selectedFlat.value) return false;
      final q = searchQuery.value.trim().toLowerCase();
      if (q.isNotEmpty && !t.name.toLowerCase().contains(q)) return false;
      return true;
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchTenants();
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchTenants() async {
    tenants.value = const [
      TenantDirectoryModel(id: 't1', name: 'Sarah Johnson', unitLabel: 'Flat 2A', propertyName: '12 Park Lane', rent: 2450),
      TenantDirectoryModel(id: 't2', name: 'David Wilson', unitLabel: 'Flat 1A', propertyName: '45 Queens Road', rent: 1850),
      TenantDirectoryModel(id: 't3', name: 'Michael Lee', unitLabel: 'Flat 2A', propertyName: '15 Victoria Ave', rent: 1950),
      TenantDirectoryModel(id: 't4', name: 'Emma Roberts', unitLabel: 'Room 1', propertyName: '88 King Street', rent: 900),
      TenantDirectoryModel(id: 't5', name: 'Priya Sharma', unitLabel: 'Flat 2B', propertyName: '12 Park Lane', rent: 2200),
      TenantDirectoryModel(id: 't6', name: 'Mark Davis', unitLabel: 'Room 3', propertyName: '88 King Street', rent: 680),
      TenantDirectoryModel(id: 't7', name: 'David Chen', unitLabel: 'Flat 1B', propertyName: '45 Queens Road', rent: 1750),
      TenantDirectoryModel(id: 't8', name: 'Michael Lee', unitLabel: 'Flat 2B', propertyName: '15 Victoria Ave', rent: 1900),
    ];
    properties.value = tenants.map((t) => t.propertyName).toSet().toList();
  }

  void applySearch(String v) => searchQuery.value = v;
  void selectProperty(String? p) {
    selectedProperty.value = p;
    flats.value = tenants.where((t) => p == null || t.propertyName == p).map((t) => t.unitLabel).toSet().toList();
    selectedFlat.value = null;
  }
  void selectFlat(String? f) => selectedFlat.value = f;

  // TODO: Replace with Dio API call once backend endpoint is ready (fetch full tenant detail by id).
  void openTenant(TenantDirectoryModel t) {
    final propertyController = Get.isRegistered<PropertyDetailController>() ? Get.find<PropertyDetailController>() : Get.put(PropertyDetailController());
    propertyController.selectedTenant.value = TenantDetailModel(
      id: t.id, fullName: t.name, unitLabel: t.unitLabel, propertyName: t.propertyName,
      dateOfBirth: '-', nid: '-', email: '-', phone: '-', emergencyContact: '-', address: '${t.unitLabel}, ${t.propertyName}',
      nidProofFileName: 'NID Proof.jpg', depositSummary: '-', keysSummary: '-', buildingInfoSummary: '${t.propertyName} · ${t.unitLabel}',
      documentsCount: 0,
      leaseAgreement: LeaseAgreementModel(documentName: 'Lease Agreement ${t.unitLabel}.pdf', issuedDate: '-', landlordName: 'John Smith'),
      deposit: DepositInfoModel(monthlyRent: t.rent, dueCharges: 0, nextMonthLabel: '-', nextMonthAmount: t.rent, depositAmount: t.rent, moveInDate: '-', scheme: '-', leaseEndsDate: '-'),
      paymentsHistory: const PaymentsHistoryModel(lastPayment: 0, lastPaymentDate: '-', nextDue: 0, nextDueDate: '-', depositHeld: 0, advancePaid: 0, stillDue: [], monthly: []),
      keySets: const [], notes: const [], documents: const [],
    );
    Get.toNamed(AppRoutes.tenantDetailsScreen);
  }
}