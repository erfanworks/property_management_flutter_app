// lib/screens/UserScreen/LandlordAllScreen/Contractors/controller/contractors_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../routes/app_routes/app_routes.dart';
import '../../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../HomeTabAllScreen/Maintenance/model/contractor_model.dart';

class ContractorsController extends GetxController {
  final RxList<ContractorModel> contractors = <ContractorModel>[].obs;
  final RxString searchQuery = ''.obs;
  final Rx<ContractorModel?> selectedContractor = Rx<ContractorModel?>(null);

  // Invite form
  final companyNameController = TextEditingController();
  final emailController = TextEditingController();
  final RxSet<String> selectedTrades = <String>{}.obs;
  static const tradeOptions = ['Plumbing & Heating', 'Electrical', 'Heating & Gas', 'General Maintenance', 'Roofing', 'Carpentry', 'Painting & Decorating'];
  final isSendingInvite = false.obs;

  List<ContractorModel> get filteredContractors {
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isEmpty) return contractors;
    return contractors.where((c) => c.name.toLowerCase().contains(q) || c.roleLabel.toLowerCase().contains(q)).toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchContractors();
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchContractors() async {
    contractors.value = [
      ContractorModel(
        id: 'c1', name: 'Electric Fix', roleLabel: 'Electrician', roleColor: const Color(0xFF7C3AED),
        isVerified: true, isOnline: true, rating: 4.8, phone: '+44 7700 900203', email: 'bookings@electricfix.co.uk',
        reviews: const [
          ReviewModel(reviewerName: 'John Smith', rating: 5, comment: 'Diagnosed tripping fuse board in 20 minutes. Replaced RCD and tested all circuits.', jobLabel: 'Fuse board tripping', dateLabel: 'Mar 15, 2025'),
          ReviewModel(reviewerName: 'Sarah Johnson', rating: 5, comment: 'Installed new LED spotlights in kitchen. Very neat wiring work.', jobLabel: 'Kitchen lighting replacement', dateLabel: 'Feb 26, 2025'),
          ReviewModel(reviewerName: 'Michael Lee', rating: 4, comment: 'Prompt arrival and issued Minor Electrical Works Certificate.', jobLabel: 'Socket replacement', dateLabel: 'Jan 18, 2025'),
        ],
      ),
      const ContractorModel(id: 'c2', name: 'Heating Co.', roleLabel: 'Heating engineer', roleColor: Color(0xFFEA580C), isVerified: true, isOnline: true, rating: 4.7, phone: '+44 7700 900204', email: 'jobs@heatingco.co.uk'),
      const ContractorModel(id: 'c3', name: 'Plumber Pro', roleLabel: 'Plumber', roleColor: Color(0xFF2563EB), isVerified: true, isOnline: true, rating: 4.8, phone: '+44 7700 900205', email: 'hello@plumberpro.co.uk'),
    ];
  }

  void applySearch(String v) => searchQuery.value = v;

  void openInvite() {
    companyNameController.clear();
    emailController.clear();
    selectedTrades.clear();
    Get.toNamed(AppRoutes.inviteContractorScreen);
  }

  void toggleTrade(String trade) => selectedTrades.contains(trade) ? selectedTrades.remove(trade) : selectedTrades.add(trade);

  // TODO: Replace with Dio API call once backend endpoint is ready.
  void sendInvite() {
    if (companyNameController.text.trim().isEmpty || emailController.text.trim().isEmpty) return;
    isSendingInvite.value = true;
    contractors.insert(0, ContractorModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: companyNameController.text.trim(),
      roleLabel: selectedTrades.isNotEmpty ? selectedTrades.first : 'General',
      roleColor: const Color(0xFF2563EB),
      email: emailController.text.trim(),
    ));
    isSendingInvite.value = false;
    AppSnackBar.success('Invite sent to ${emailController.text.trim()}');
    Get.back();
  }

  void openDetail(ContractorModel c) {
    selectedContractor.value = c;
    Get.toNamed(AppRoutes.contractorDetailScreen);
  }

  void openReviews() => Get.toNamed(AppRoutes.contractorReviewsScreen);
}