// lib/screens/UserScreen/LandlordAllScreen/PropertyDetail/controller/property_detail_controller.dart
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../models/property_model.dart';
import '../../../../../../routes/app_routes/app_routes.dart';
import '../../../../../../widget/ConfirmActionDialog/confirm_action_dialog.dart';
import '../../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';
import '../../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../Properties/model/properties_filter.dart';
import '../Tenant/widget/upload_document_bottom_sheet.dart';
import '../UnitDetail/controller/unit_detail_controller.dart';
import '../model/property_detail_model.dart';
import '../model/service_model.dart';

class PropertyDetailController extends GetxController {
  final Rx<PropertyModel?> property = Rx<PropertyModel?>(null);
  final RxInt selectedTabIndex = 0.obs;

  final RxList<FloorGroupModel> floors = <FloorGroupModel>[].obs;
  final Rx<PropertiesFilter> unitFilter = PropertiesFilter.all.obs;
  final RxSet<String> expandedFloors = <String>{}.obs;

  final RxList<PropertyTenantModel> tenants = <PropertyTenantModel>[].obs;
  final Rx<TenantDetailModel?> selectedTenant = Rx<TenantDetailModel?>(null);

  final RxList<ServiceModel> services = <ServiceModel>[].obs;
  final Rx<ServiceModel?> selectedService = Rx<ServiceModel?>(null);
  final RxList<ServiceFieldModel> editingFields = <ServiceFieldModel>[].obs;
  final Rx<String?> editingPhotoPath = Rx<String?>(null);
  final isSavingService = false.obs;

  final RxList<KeySetModel> editingKeySets = <KeySetModel>[].obs;
  final RxList<TenantNoteModel> tenantNotesRx = <TenantNoteModel>[].obs;
  final noteTextController = TextEditingController();
  final RxList<TenantDocumentModel> tenantDocumentsRx = <TenantDocumentModel>[].obs;

  final Rx<UnitModel?> inviteUnit = Rx<UnitModel?>(null);
  final inviteEmailController = TextEditingController();
  final invitePersonalMessageController = TextEditingController();
  final flatRentController = TextEditingController();
  final Rx<DateTime?> leaseStartDate = Rx<DateTime?>(null);
  final Rx<DateTime?> leaseEndDate = Rx<DateTime?>(null);
  final securityDepositController = TextEditingController();
  final advanceRentController = TextEditingController();
  final Rx<DepositScheme?> inviteDepositScheme = Rx<DepositScheme?>(null);
  final protectionReferenceController = TextEditingController();
  final isSendingInvite = false.obs;

  int get totalFloors => floors.length;

  int get totalUnits => floors.fold(0, (sum, f) => sum + f.units.length);

  int get occupiedUnits => floors.fold(0, (sum, f) => sum + f.units.where((u) => u.isOccupied).length);

  int get vacantUnits => totalUnits - occupiedUnits;

  double get totalRent => floors.fold(0.0, (sum, f) => sum + f.units.fold(0.0, (s, u) => s + u.rent));

  List<FloorGroupModel> get filteredFloors {
    if (unitFilter.value == PropertiesFilter.all) return floors;
    return floors
        .map((f) => FloorGroupModel(
              floorLabel: f.floorLabel,
              units: f.units
                  .where((u) => unitFilter.value == PropertiesFilter.occupied ? u.isOccupied : !u.isOccupied)
                  .toList(),
            ))
        .where((f) => f.units.isNotEmpty)
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is PropertyModel) {
      property.value = Get.arguments as PropertyModel;
    }
    selectedTabIndex.value = 0;
    fetchFloors();
    fetchTenants();
    fetchServices();
  }

  void selectTab(int index) => selectedTabIndex.value = index;

  void selectUnitFilter(PropertiesFilter filter) => unitFilter.value = filter;

  void toggleFloorExpanded(String floorLabel) {
    expandedFloors.contains(floorLabel)
        ? expandedFloors.remove(floorLabel)
        : expandedFloors.add(floorLabel);
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchFloors() async {
    floors.value = const [
      FloorGroupModel(floorLabel: '1st Floor', units: [
        UnitDetailModel(id: 'u1', label: 'Flat 1A', floorLabel: '1st Floor', bedBathLabel: '1 Bed · 1 Bath', rent: 2450, isOccupied: false),
        UnitDetailModel(id: 'u2', label: 'Flat 1B', floorLabel: '1st Floor', bedBathLabel: '1 Bed · 1 Bath', rent: 2450, isOccupied: false),
      ]),
      FloorGroupModel(floorLabel: '2nd Floor', units: [
        UnitDetailModel(id: 'u3', label: 'Flat 2A', floorLabel: '2nd Floor', bedBathLabel: '1 Bed · 1 Bath', rent: 2450, isOccupied: true, tenantId: 't1'),
        UnitDetailModel(id: 'u4', label: 'Flat 2B', floorLabel: '2nd Floor', bedBathLabel: '1 Bed · 1 Bath', rent: 2200, isOccupied: true, tenantId: 't2'),
      ]),
      FloorGroupModel(floorLabel: '3rd Floor', units: [
        UnitDetailModel(id: 'u5', label: 'Flat 1A', floorLabel: '3rd Floor', bedBathLabel: '1 Bed · 1 Bath', rent: 2450, isOccupied: false),
        UnitDetailModel(id: 'u6', label: 'Flat 1B', floorLabel: '3rd Floor', bedBathLabel: '1 Bed · 1 Bath', rent: 2450, isOccupied: false),
      ]),
    ];
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchTenants() async {
    tenants.value = const [
      PropertyTenantModel(id: 't1', name: 'Sarah Johnson', unitLabel: 'Flat 2A', rent: 2450),
      PropertyTenantModel(id: 't2', name: 'Priya Sharma', unitLabel: 'Flat 2B', rent: 2200),
    ];
  }

  // TODO: Replace with Dio API call once backend endpoint is ready (fetch full tenant detail by id).
  void openTenantDetails(PropertyTenantModel tenant) {
    selectedTenant.value = TenantDetailModel(
      id: tenant.id,
      fullName: tenant.name,
      isActive: tenant.isActive,
      unitLabel: tenant.unitLabel,
      propertyName: property.value?.name ?? '',
      dateOfBirth: '18 Apr 1992',
      nid: '4859217360',
      email: 'sarah.j@email.com',
      phone: '+44 7700 900456',
      emergencyContact: '+44 7700 900789',
      address: 'Flat 2A, 12 Park Lane, London',
      nidProofFileName: 'NID Proof.jpg',
      depositSummary: 'Deposited £2,450 · 15 Jan 2024 · MyDeposits',
      keysSummary: '3 keys assigned · Front entrance key',
      buildingInfoSummary: '${property.value?.name ?? ''} · ${tenant.unitLabel} · Floor 2',
      documentsCount: 6,
      latestNoteSummary: 'Tenant prefers email for non-urgent matters. Very responsive on WhatsApp...',
      latestNoteDateLabel: 'Mar 5, 2025',
      leaseAgreement: const LeaseAgreementModel(
        documentName: 'Lease Agreement Flat 2A.pdf',
        issuedDate: 'Jan 15, 2024',
        landlordName: 'John Smith',
      ),
      deposit: const DepositInfoModel(
        monthlyRent: 2450,
        dueCharges: 85,
        nextMonthLabel: 'Jul 1, 2026',
        nextMonthAmount: 2450,
        depositAmount: 2450,
        moveInDate: '15 Jan 2024',
        scheme: 'MyDeposits',
        leaseEndsDate: '14 Jan 2027',
      ),
      paymentsHistory: const PaymentsHistoryModel(
        lastPayment: 2450,
        lastPaymentDate: 'Sep 2, 2026',
        nextDue: 2450,
        nextDueDate: 'Jul 1, 2026',
        depositHeld: 2450,
        advancePaid: 2450,
        stillDue: [
          PaymentHistoryEntryModel(label: 'Rent', dueDateLabel: 'Jul 1, 2026', amount: 2450, isPaid: false),
          PaymentHistoryEntryModel(label: 'Extra charges', dueDateLabel: 'Jul 20, 2026', amount: 85, isPaid: false),
        ],
        monthly: [
          PaymentHistoryEntryModel(label: 'Sept 2026 · Rent', dueDateLabel: 'Sep 2, 2026', amount: 2450),
          PaymentHistoryEntryModel(label: 'May 2026 · Rent', dueDateLabel: 'May 2, 2026', amount: 2450),
          PaymentHistoryEntryModel(label: 'Mar 2026 · Rent', dueDateLabel: 'Mar 2, 2026', amount: 2450),
          PaymentHistoryEntryModel(label: 'Jun 2026 · Rent', dueDateLabel: 'Jun 2, 2026', amount: 2450),
          PaymentHistoryEntryModel(label: 'Apr 2026 · Rent', dueDateLabel: 'Apr 2, 2026', amount: 2450),
        ],
      ),
      keySets: const [
        KeySetModel(id: 'k1', keyType: 'Front entrance key', quantity: 2, location: 'Flat entrance', heldBy: 'Sarah Johnson'),
        KeySetModel(id: 'k2', keyType: 'Building electronic fob', quantity: 2, location: 'Lobby & underground gate', heldBy: 'Sarah Johnson'),
        KeySetModel(id: 'k3', keyType: 'Mailbox key', quantity: 1, location: 'Ground floor post room', heldBy: 'Sarah Johnson'),
        KeySetModel(id: 'k4', keyType: 'Master landlord key', quantity: 1, location: 'Key safe at office', heldBy: 'John Smith'),
      ],
      notes: const [
        TenantNoteModel(id: 'n1', text: 'Tenant prefers email for non-urgent matters. Very responsive on WhatsApp.', dateLabel: 'Mar 5, 2025', authorLabel: 'You'),
        TenantNoteModel(id: 'n2', text: 'Requested early inspection before lease renewal discussion.', dateLabel: 'Feb 12, 2025', authorLabel: 'You'),
        TenantNoteModel(id: 'n3', text: 'Reported minor kitchen sink leak — Plumber Pro dispatched same day.', dateLabel: 'Mar 10, 2025', authorLabel: 'You'),
      ],
      documents: const [
        TenantDocumentModel(id: 'd1', fileName: 'Lease Agreement Flat 2A.pdf', dateLabel: 'Jan 15, 2024', categoryLabel: 'Tenancy agreement'),
        TenantDocumentModel(id: 'd2', fileName: 'NID Proof Sarah Johnson.jpg', dateLabel: 'Jan 10, 2024', categoryLabel: 'Other file'),
        TenantDocumentModel(id: 'd3', fileName: 'Gas Safety CP12 2026.pdf', dateLabel: 'Mar 2026', categoryLabel: 'Gas safety (CP12)'),
        TenantDocumentModel(id: 'd4', fileName: 'EICR Electrical Report.pdf', dateLabel: 'Aug 2025', categoryLabel: 'Electrical (EICR)'),
        TenantDocumentModel(id: 'd5', fileName: 'Deposit Protection Certificate.pdf', dateLabel: 'Jan 2024', categoryLabel: 'Deposit protection'),
        TenantDocumentModel(id: 'd6', fileName: 'Move-in Inventory Schedule.pdf', dateLabel: 'Jan 15, 2024', categoryLabel: 'Other file'),
      ],
    );
    Get.toNamed(AppRoutes.tenantDetailsScreen);
  }

  void openLeaseAgreement() => Get.toNamed(AppRoutes.leaseAgreementScreen);

  void openNidDocument() => Get.toNamed(AppRoutes.nidDocumentScreen);

  void openDeposit() => Get.toNamed(AppRoutes.tenantDepositScreen);

  void openPaymentsHistory() => Get.toNamed(AppRoutes.tenantPaymentsHistoryScreen);

  void openKeys() => Get.toNamed(AppRoutes.tenantKeysScreen);

  void openEditKeys() {
    editingKeySets.value = selectedTenant.value?.keySets.map((k) => KeySetModel(
          id: k.id,
          keyType: k.keyType,
          quantity: k.quantity,
          location: k.location,
          heldBy: k.heldBy,
        )).toList() ?? [];
    Get.toNamed(AppRoutes.tenantEditKeysScreen);
  }

  void updateEditingKeyField(String id, {String? keyType, int? quantity, String? location, String? heldBy}) {
    final index = editingKeySets.indexWhere((k) => k.id == id);
    if (index == -1) return;
    final k = editingKeySets[index];
    editingKeySets[index] = KeySetModel(
      id: k.id,
      keyType: keyType ?? k.keyType,
      quantity: quantity ?? k.quantity,
      location: location ?? k.location,
      heldBy: heldBy ?? k.heldBy,
    );
  }

  void removeEditingKeySet(String id) => editingKeySets.removeWhere((k) => k.id == id);

  void addEditingKeySet() {
    editingKeySets.add(KeySetModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      keyType: '',
      quantity: 1,
      location: '',
      heldBy: '',
    ));
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  void saveKeys() {
    final tenant = selectedTenant.value;
    if (tenant == null) return;
    selectedTenant.value = TenantDetailModel(
      id: tenant.id,
      fullName: tenant.fullName,
      avatarUrl: tenant.avatarUrl,
      isActive: tenant.isActive,
      unitLabel: tenant.unitLabel,
      propertyName: tenant.propertyName,
      dateOfBirth: tenant.dateOfBirth,
      nid: tenant.nid,
      email: tenant.email,
      phone: tenant.phone,
      emergencyContact: tenant.emergencyContact,
      address: tenant.address,
      nidProofFileName: tenant.nidProofFileName,
      depositSummary: tenant.depositSummary,
      keysSummary: '${editingKeySets.length} keys assigned · ${editingKeySets.isNotEmpty ? editingKeySets.first.keyType : ''}',
      buildingInfoSummary: tenant.buildingInfoSummary,
      documentsCount: tenant.documentsCount,
      latestNoteSummary: tenant.latestNoteSummary,
      latestNoteDateLabel: tenant.latestNoteDateLabel,
      leaseAgreement: tenant.leaseAgreement,
      deposit: tenant.deposit,
      paymentsHistory: tenant.paymentsHistory,
      keySets: List.of(editingKeySets),
      notes: tenant.notes,
      documents: tenant.documents,
    );
    AppSnackBar.success('Keys updated');
    Get.back();
  }

  void openNotes() {
    tenantNotesRx.value = List.of(selectedTenant.value?.notes ?? []);
    Get.toNamed(AppRoutes.tenantNotesScreen);
  }

  void openAddNote() {
    noteTextController.clear();
    Get.toNamed(AppRoutes.tenantAddNoteScreen);
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  void saveNote() {
    if (noteTextController.text.trim().isEmpty) return;
    tenantNotesRx.insert(0, TenantNoteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: noteTextController.text.trim(),
      dateLabel: 'Just now',
      authorLabel: 'You',
    ));
    AppSnackBar.success('Note saved');
    Get.back();
  }

  void confirmDeleteNote(String id) {
    ConfirmActionDialog.show(
      title: ConstString.deleteNote,
      message: ConstString.removeThisNote,
      confirmLabel: ConstString.delete,
      onConfirm: () {
        tenantNotesRx.removeWhere((n) => n.id == id);
        AppSnackBar.success('Note deleted');
      },
    );
  }

  void openDocuments() {
    tenantDocumentsRx.value = List.of(selectedTenant.value?.documents ?? []);
    Get.toNamed(AppRoutes.tenantDocumentsScreen);
  }

  void showUploadDocumentPicker() {
    Get.bottomSheet(
      const UploadDocumentBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> pickAndUploadTenantDocument(UploadDocCategory category) async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    final file = files.firstOrNull;
    if (file == null) return;
    // TODO: Replace with Dio API upload call once backend endpoint is ready.
    tenantDocumentsRx.insert(0, TenantDocumentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fileName: file.name,
      dateLabel: 'Just now',
      categoryLabel: category.label,
    ));
    AppSnackBar.success('Document uploaded');
  }

  void openInviteTenant() {
    inviteUnit.value = null;
    inviteEmailController.clear();
    invitePersonalMessageController.clear();
    flatRentController.clear();
    leaseStartDate.value = null;
    leaseEndDate.value = null;
    securityDepositController.clear();
    advanceRentController.clear();
    inviteDepositScheme.value = null;
    protectionReferenceController.clear();
    Get.toNamed(AppRoutes.inviteTenantStep1Screen);
  }

  bool get canProceedInviteStep1 => inviteUnit.value != null && inviteEmailController.text.trim().isNotEmpty;

  bool get canProceedInviteStep2 => flatRentController.text.trim().isNotEmpty && leaseStartDate.value != null && leaseEndDate.value != null;

  void goToInviteStep2() {
    if (!canProceedInviteStep1) return;
    Get.toNamed(AppRoutes.inviteTenantStep2Screen);
  }

  void goToInviteStep3() {
    if (!canProceedInviteStep2) return;
    Get.toNamed(AppRoutes.inviteTenantStep3Screen);
  }

  Future<void> pickLeaseDate(BuildContext context, Rx<DateTime?> target) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) target.value = picked;
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> sendInvitation() async {
    isSendingInvite.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isSendingInvite.value = false;
    AppSnackBar.success('Invitation sent to ${inviteEmailController.text.trim()}');
    Get.until((route) => route.settings.name == AppRoutes.propertyDetailScreen);
  }

  Future<void> fetchServices() async {
    services.value = [
      ServiceModel(
        type: ServiceType.gas,
        photoPath: 'assets/images/service_gas.png',
        summaryLine: 'British Gas (Smart Meter) · MPRN 84920173',
        fields: [
          ServiceFieldModel(key: 'supplier', label: 'Supplier', value: 'British Gas'),
          ServiceFieldModel(key: 'mprn', label: 'MPRN', value: '489201'),
          ServiceFieldModel(key: 'location', label: 'Location', value: 'Cupboard under the stairs'),
          ServiceFieldModel(key: 'shutoff', label: 'Shut-off', value: 'Lever beside meter'),
          ServiceFieldModel(key: 'helpline', label: 'Helpline', value: '0800 111 999'),
          ServiceFieldModel(key: 'tariff', label: 'Tariff / Notes', value: 'Fixed rate until 2026', isMultiline: true),
        ],
      ),
      ServiceModel(
        type: ServiceType.electricity,
        photoPath: 'assets/images/service_electricity.png',
        summaryLine: 'Octopus Energy (MPAN) · 120002948192',
        fields: [
          ServiceFieldModel(key: 'supplier', label: 'Supplier', value: 'Octopus Energy'),
          ServiceFieldModel(key: 'mpan', label: 'MPAN', value: '120002948192'),
          ServiceFieldModel(key: 'location', label: 'Location', value: 'Basement intake cupboard'),
          ServiceFieldModel(key: 'consumer_unit', label: 'Consumer unit', value: 'Hallway cupboard · main RCD'),
          ServiceFieldModel(key: 'helpline', label: 'Helpline', value: '0808 164 1088'),
          ServiceFieldModel(key: 'tariff', label: 'Tariff / Notes', value: 'Agile eco tariff', isMultiline: true),
        ],
      ),
      ServiceModel(
        type: ServiceType.water,
        photoPath: 'assets/images/service_water.png',
        summaryLine: 'Thames Water (Account: 902184) · Meter WTR-99402',
        fields: [
          ServiceFieldModel(key: 'supplier', label: 'Supplier', value: 'Thames Water'),
          ServiceFieldModel(key: 'account', label: 'Account / Meter', value: '902184'),
          ServiceFieldModel(key: 'stopcock', label: 'Stopcock', value: 'Under kitchen sink'),
          ServiceFieldModel(key: 'street_valve', label: 'Street valve', value: 'Pavement outside front boundary'),
          ServiceFieldModel(key: 'helpline', label: 'Helpline', value: '0800 316 9800'),
          ServiceFieldModel(key: 'tariff', label: 'Tariff / Notes', value: 'Unmetered flat rate', isMultiline: true),
        ],
      ),
      ServiceModel(
        type: ServiceType.wifi,
        photoPath: 'assets/images/service_wifi.png',
        summaryLine: 'BT Full Fibre 500 · 900 Mbps',
        fields: [
          ServiceFieldModel(key: 'provider', label: 'Provider', value: 'BT Full Fibre 500'),
          ServiceFieldModel(key: 'network', label: 'Network', value: 'BT-HQ-Building-5G'),
          ServiceFieldModel(key: 'password', label: 'Password', value: 'FastSecure2025!'),
          ServiceFieldModel(key: 'router', label: 'Router', value: 'Hallway cupboard, ground floor'),
          ServiceFieldModel(key: 'support', label: 'Support', value: '0800 800 150'),
          ServiceFieldModel(key: 'speed', label: 'Speed / Notes', value: 'Full fibre · 900 Mbps', isMultiline: true),
        ],
      ),
      ServiceModel(
        type: ServiceType.council,
        photoPath: 'assets/images/service_council.png',
        summaryLine: 'Band Band D · Westminster City Council',
        fields: [
          ServiceFieldModel(key: 'authority', label: 'Authority', value: 'Westminster City Council'),
          ServiceFieldModel(key: 'tax_band', label: 'Tax band', value: 'Band D', dropdownOptions: [
            'Band A',
            'Band B',
            'Band C',
            'Band D',
            'Band E',
            'Band F',
            'Band G',
            'Band H',
            'Not applicable'
          ]),
          ServiceFieldModel(key: 'reference', label: 'Reference', value: 'WCC-8941029'),
          ServiceFieldModel(key: 'contact', label: 'Contact', value: '020 7641 6000'),
          ServiceFieldModel(key: 'bins', label: 'Bins', value: 'Waste Tue · Recycling Fri'),
        ],
      ),
      ServiceModel(
        type: ServiceType.parking,
        photoPath: 'assets/images/service_parking.png',
        summaryLine: 'Secure underground · 4 Allocated Bay(s)',
        fields: [
          ServiceFieldModel(key: 'type', label: 'Type', value: 'Secure underground'),
          ServiceFieldModel(key: 'spaces', label: 'Spaces / Bays', value: 'Bays 1 to 4'),
          ServiceFieldModel(key: 'permit', label: 'Permit', value: 'PL-BAY-01 to 04'),
          ServiceFieldModel(key: 'allocated', label: 'Allocated count', value: '4'),
          ServiceFieldModel(key: 'access', label: 'Access / Notes', value: 'Automated fob gate, EV charge points', isMultiline: true),
        ],
      ),
    ];
  }

  void openPropertyPhotos() => Get.toNamed(AppRoutes.propertyPhotosScreen);

  void openFloorPlans() => Get.toNamed(AppRoutes.floorPlansScreen);

  void openServicesMeters() => Get.toNamed(AppRoutes.servicesMetersScreen);

  void openServiceDetail(ServiceModel service) {
    selectedService.value = service;
    Get.toNamed(AppRoutes.serviceDetailScreen);
  }

  void openServiceEdit() {
    final service = selectedService.value;
    if (service == null) return;
    editingFields.value = service.fields.map((f) => f.copy()).toList();
    editingPhotoPath.value = service.photoPath;
    Get.toNamed(AppRoutes.serviceEditScreen);
  }

  Future<void> pickServicePhoto() async {
    await MediaPickerBottomSheet.show(
      onCamera: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80);
        if (file != null) editingPhotoPath.value = file.path;
      },
      onGallery: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
        if (file != null) editingPhotoPath.value = file.path;
      },
    );
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> saveServiceEdit() async {
    final current = selectedService.value;
    if (current == null) return;
    isSavingService.value = true;
    await Future.delayed(const Duration(milliseconds: 600));

    final updated = ServiceModel(
      type: current.type,
      photoPath: editingPhotoPath.value,
      fields: editingFields.map((f) => f.copy()).toList(),
    );
    final index = services.indexWhere((s) => s.type == current.type);
    if (index != -1) services[index] = updated;
    selectedService.value = updated;

    isSavingService.value = false;
    AppSnackBar.success('${current.type.label} info updated');
    Get.back();
  }

  Future<void> addPropertyPhoto() async {
    await MediaPickerBottomSheet.show(
      onCamera: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80);
        if (file != null) _appendPropertyPhoto(file.path);
      },
      onGallery: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
        if (file != null) _appendPropertyPhoto(file.path);
      },
    );
  }

  void _appendPropertyPhoto(String path) {
    final current = property.value;
    if (current == null) return;
    property.value = current.copyWith(photoUrls: [...current.photoUrls, path]);
  }

  void setPhotoAsCover(int index) {
    final current = property.value;
    if (current == null) return;
    final list = List<String>.of(current.photoUrls);
    final photo = list.removeAt(index);
    list.insert(0, photo);
    property.value = current.copyWith(photoUrls: list);
  }

  void removePropertyPhoto(int index) {
    final current = property.value;
    if (current == null) return;
    final list = List<String>.of(current.photoUrls)..removeAt(index);
    property.value = current.copyWith(photoUrls: list);
  }

  Future<void> addFloorPlan() async {
    await MediaPickerBottomSheet.show(
      onCamera: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80);
        if (file != null) _appendFloorPlan(file.path);
      },
      onGallery: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
        if (file != null) _appendFloorPlan(file.path);
      },
    );
  }

  void _appendFloorPlan(String path) {
    final current = property.value;
    if (current == null) return;
    property.value = current.copyWith(floorPlanUrls: [...current.floorPlanUrls, path]);
  }

  void removeFloorPlan(int index) {
    final current = property.value;
    if (current == null) return;
    final list = List<String>.of(current.floorPlanUrls)..removeAt(index);
    property.value = current.copyWith(floorPlanUrls: list);
  }

  void notifyComingSoon(String feature) => Get.toNamed(AppRoutes.chatDetailScreen);
  void viewRent(String feature) => Get.toNamed("");

  void openUnitDetail(UnitDetailModel unitSummary) {
    final unitController = Get.put(UnitDetailController());
    unitController.loadUnit(propertyName: property.value?.name ?? '', unitSummary: unitSummary);
    Get.toNamed(AppRoutes.unitDetailScreen);
  }
}
