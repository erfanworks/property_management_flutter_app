// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/controller/records_controller.dart
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import '../../../../../../../routes/app_routes/app_routes.dart';
import '../../../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../model/records_model.dart';

class RecordsController extends GetxController {
  final RxMap<ComplianceType, List<CertificateFileModel>> complianceCerts = <ComplianceType, List<CertificateFileModel>>{}.obs;
  final RxList<OtherDocumentModel> otherDocuments = <OtherDocumentModel>[].obs;
  final Rx<ComplianceType?> selectedComplianceType = Rx<ComplianceType?>(null);
  final Rx<CertificateFileModel?> selectedCertificate = Rx<CertificateFileModel?>(null);

  List<CertificateFileModel> certsFor(ComplianceType type) => complianceCerts[type] ?? const [];
  CertificateFileModel? currentCertFor(ComplianceType type) => certsFor(type).where((c) => c.isCurrent).firstOrNull;
  List<CertificateFileModel> historyFor(ComplianceType type) => certsFor(type).where((c) => !c.isCurrent).toList();

  @override
  void onInit() {
    super.onInit();
    fetchComplianceData();
    fetchOtherDocuments();
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchComplianceData() async {
    complianceCerts.value = {
      ComplianceType.gasSafety: [
        CertificateFileModel(
          id: 'g1', fileName: 'Gas Certificate 2026.pdf', sizeLabel: '890 KB', dateLabel: 'Mar 2026', isCurrent: true,
          refCertNo: 'GS-2026-001', propertyAddress: 'Flat 2A, London, SW1A 1AA', landlordOwner: 'John Smith',
          inspectionDate: 'Mar 2026', nextDueDate: '2026-03-15', engineerName: 'SafeGas Ltd',
          engineerNotes: 'All 4 boilers passed safety inspection',
          applianceChecks: const [
            ApplianceCheckModel(name: 'Central Heating Boiler', detail: 'Flat 2A · Operating pressure: 21 mbar · Flue flow: Pass', passed: true),
            ApplianceCheckModel(name: 'Gas Hob & Pipework', detail: 'Flame safety device & tightness: Pass', passed: true),
          ],
          overallOutcome: 'PASSED & CERTIFIED',
        ),
        const CertificateFileModel(id: 'g2', fileName: 'Gas Certificate 2025.pdf', sizeLabel: '890 KB', dateLabel: 'Mar 2025'),
        const CertificateFileModel(id: 'g3', fileName: 'Gas Certificate 2024.pdf', sizeLabel: '2.1 MB', dateLabel: 'Mar 2024'),
      ],
      ComplianceType.electricalEicr: [
        const CertificateFileModel(id: 'e1', fileName: 'EICR Report 2025.pdf', sizeLabel: '2.1 MB', dateLabel: 'Aug 2025', isCurrent: true),
        const CertificateFileModel(id: 'e2', fileName: 'EICR Report 2020.pdf', sizeLabel: '1.2 MB', dateLabel: 'Aug 2020'),
      ],
      ComplianceType.energyPerformance: [
        const CertificateFileModel(id: 'ep1', fileName: 'EPC Rating B.pdf', sizeLabel: '450 KB', dateLabel: 'Jun 2023', isCurrent: true),
      ],
      ComplianceType.landlordInsurance: const [],
      ComplianceType.depositProtection: [
        const CertificateFileModel(id: 'd1', fileName: 'Deposit Protection Flat 2A.pdf', sizeLabel: '680 KB', dateLabel: 'Jan 2024', isCurrent: true),
      ],
      ComplianceType.propertyLicence: [
        const CertificateFileModel(id: 'pl1', fileName: 'Property Licence.pdf', sizeLabel: '2.1 MB', dateLabel: 'Jan 2025', isCurrent: true),
      ],
    };
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchOtherDocuments() async {
    otherDocuments.value = [
      const OtherDocumentModel(id: 'od1', fileName: 'Lease Agreement Flat 2A.pdf', dateLabel: 'Jan 15, 2024', categoryLabel: 'Tenancy Agreement', isShared: true),
      const OtherDocumentModel(id: 'od2', fileName: 'EICR Report 2020.pdf', dateLabel: 'Aug 2020', categoryLabel: 'Electrical Certificate', isShared: true),
      const OtherDocumentModel(id: 'od3', fileName: 'Selective Licensing Certificate.pdf', dateLabel: 'Sep 2024', categoryLabel: 'Property Licence', isShared: true),
      const OtherDocumentModel(id: 'od4', fileName: 'Legionella Risk Assessment.pdf', dateLabel: 'Nov 2024', categoryLabel: 'Custom Document', isShared: true),
      const OtherDocumentModel(id: 'od5', fileName: 'Land Registry Title Deed.pdf', dateLabel: 'Oct 2023', categoryLabel: 'Custom Document'),
      const OtherDocumentModel(id: 'od6', fileName: 'Building Warranty Certificate.pdf', dateLabel: 'Dec 2023', categoryLabel: 'Custom Document', isShared: true),
    ];
  }

  void openComplianceHub() => Get.toNamed(AppRoutes.complianceHubScreen);

  void openCertificateList(ComplianceType type) {
    selectedComplianceType.value = type;
    if (type == ComplianceType.otherDocuments) {
      Get.toNamed(AppRoutes.otherDocumentsScreen);
    } else {
      Get.toNamed(AppRoutes.certificateListScreen);
    }
  }

  void openCertificateDetail(CertificateFileModel cert) {
    selectedCertificate.value = cert;
    Get.toNamed(AppRoutes.gasCertificateDetailScreen);
  }

  Future<void> pickAndUploadCertificate(ComplianceType type) async {
    final files = await FilePicker.pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png']);
    final file = files.firstOrNull;
    if (file == null) return;

    // TODO: Replace with Dio API upload call once backend endpoint is ready.
    final bytes = file.lengthSync() ?? 0;
    final sizeLabel = '${(bytes / 1024).toStringAsFixed(0)} KB';
    final newCert = CertificateFileModel(id: DateTime.now().millisecondsSinceEpoch.toString(), fileName: file.name, sizeLabel: sizeLabel, dateLabel: 'Just now', isCurrent: true);

    final list = List<CertificateFileModel>.of(certsFor(type)).map((c) => CertificateFileModel(
      id: c.id, fileName: c.fileName, sizeLabel: c.sizeLabel, dateLabel: c.dateLabel, isCurrent: false,
      refCertNo: c.refCertNo, propertyAddress: c.propertyAddress, landlordOwner: c.landlordOwner,
      inspectionDate: c.inspectionDate, nextDueDate: c.nextDueDate, engineerName: c.engineerName,
      engineerNotes: c.engineerNotes, applianceChecks: c.applianceChecks, overallOutcome: c.overallOutcome,
    )).toList();
    list.insert(0, newCert);
    complianceCerts[type] = list;
    AppSnackBar.success('Certificate uploaded');
  }

  Future<void> pickAndUploadOtherDocument({required String categoryLabel}) async {
    final files = await FilePicker.pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png']);
    final file = files.firstOrNull;
    if (file == null) return;

    // TODO: Replace with Dio API upload call once backend endpoint is ready.
    final list = List<OtherDocumentModel>.of(otherDocuments);
    list.insert(0, OtherDocumentModel(id: DateTime.now().millisecondsSinceEpoch.toString(), fileName: file.name, dateLabel: 'Just now', categoryLabel: categoryLabel));
    otherDocuments.value = list;
    AppSnackBar.success('Document uploaded');
  }

  void deleteOtherDocument(String id) {
    otherDocuments.value = otherDocuments.where((d) => d.id != id).toList();
    AppSnackBar.success('Document removed');
  }

  void deleteCertificate(ComplianceType type, String id) {
    complianceCerts[type] = certsFor(type).where((c) => c.id != id).toList();
    Get.back();
    AppSnackBar.success('Certificate deleted');
  }

  // TODO: Wire real download once backend serves file URLs.
  void downloadDocument(String fileName) => AppSnackBar.message('Downloading $fileName...');

  void shareDocument(String fileName) => AppSnackBar.message('Sharing $fileName...');

  void notifyComingSoon(String feature) => AppSnackBar.message('$feature is coming soon!');
}
