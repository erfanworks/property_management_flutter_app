// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/controller/house_rules_controller.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' hide Document;
import '../../../../../../../routes/app_routes/app_routes.dart';
import '../../../../../../../widget/app_snack_bar/app_snack_bar.dart';

class HouseRulesController extends GetxController {
  final RxList<String> rules = <String>[].obs;
  late QuillController quillController;

  @override
  void onInit() {
    super.onInit();
    fetchRules();
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchRules() async {
    rules.value = [
      'Quiet hours after 10 PM — keep noise down for neighbours.',
      'Report maintenance issues through the app so your landlord can respond quickly.',
      'No smoking inside the building or communal areas.',
      'Guests may not stay more than 14 consecutive nights without written approval.',
      'Recycling bins are in the rear garden shed — please sort waste correctly.',
      'Bicycle storage is in the basement — do not leave bikes in the hallway.',
    ];
  }

  void openEdit() {
    final doc = Document()..insert(0, rules.map((r) => '$r\n').join());
    quillController = QuillController(document: doc, selection: const TextSelection.collapsed(offset: 0));
    Get.toNamed(AppRoutes.editHouseRulesScreen);
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  void saveRules() {
    final text = quillController.document.toPlainText().trim();
    rules.value = text.split('\n').where((l) => l.trim().isNotEmpty).toList();
    AppSnackBar.success('House rules updated');
    Get.back();
  }
}