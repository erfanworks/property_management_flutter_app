// lib/screens/UserScreen/LandlordAllScreen/Finance/controller/finance_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/ConfirmActionDialog/confirm_action_dialog.dart';
import '../../../../../widget/ReceiptPdfGenerator/receipt_pdf_generator.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../model/finance_reference_model.dart';
import '../model/finance_summary_model.dart';
import '../model/transaction_model.dart';

class FinanceController extends GetxController {
  final Rx<FinanceTab> selectedTab = FinanceTab.all.obs;
  final RxMap<FinanceTab, FinanceSummaryModel> summaryByTab = <FinanceTab, FinanceSummaryModel>{}.obs;
  final RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  final RxBool showPaidTab = false.obs; // false = Outstanding, true = Paid
  final Rx<TransactionModel?> selectedTransaction = Rx<TransactionModel?>(null);

  final RxList<FinancePropertyModel> financeProperties = <FinancePropertyModel>[].obs;

  final Rx<ChargeType?> chargeType = Rx<ChargeType?>(null);
  final Rx<BilledTo> billedTo = BilledTo.allTenantsOnUnit.obs;
  final Rx<FinancePropertyModel?> chargeProperty = Rx<FinancePropertyModel?>(null);
  final Rx<UnitOptionModel?> chargeUnit = Rx<UnitOptionModel?>(null);
  final Rx<TenantOptionModel?> chargeTenant = Rx<TenantOptionModel?>(null);
  final chargeAmountController = TextEditingController();
  final Rx<DateTime?> chargeDueDate = Rx<DateTime?>(null);
  final chargeDescriptionController = TextEditingController();
  final canSubmitChargeRx = false.obs;
  final isSubmittingCharge = false.obs;

  final RxSet<String> selectedReminderIds = <String>{}.obs;
  final reminderMessageController = TextEditingController();
  final isSendingReminder = false.obs;

  final RxSet<String> selectedPaymentIds = <String>{}.obs;
  final Rx<DateTime?> paymentReceivedOn = Rx<DateTime?>(null);
  final Rx<PaymentMethod> paymentMethod = PaymentMethod.bankTransfer.obs;
  final paymentReferenceController = TextEditingController();
  final paymentAmountReceivedController = TextEditingController();
  final paymentNotesController = TextEditingController();
  final receiptSentToTenant = false.obs;
  final isSubmittingPayment = false.obs;

  FinanceSummaryModel get currentSummary => summaryByTab[selectedTab.value]!;

  List<TransactionModel> get currentTabTransactions {
    if (selectedTab.value == FinanceTab.all) return transactions;
    final category = selectedTab.value == FinanceTab.rent ? TransactionCategory.rent : TransactionCategory.charge;
    return transactions.where((t) => t.category == category).toList();
  }

  List<TransactionModel> get historyFilteredTransactions {
    final base = currentTabTransactions;
    return base.where((t) => showPaidTab.value ? t.status == TransactionStatus.paid : t.status != TransactionStatus.paid).toList();
  }

  List<TransactionModel> get outstandingTransactions => transactions.where((t) => t.status != TransactionStatus.paid).toList();

  Map<String, List<TransactionModel>> get outstandingByProperty {
    final map = <String, List<TransactionModel>>{};
    for (final t in outstandingTransactions) {
      map.putIfAbsent(t.propertyName, () => []).add(t);
    }
    return map;
  }

  double get totalOutstandingAmount => outstandingTransactions.fold(0, (sum, t) => sum + t.amount);
  int get outstandingTenantCount => outstandingTransactions.length;
  List<TransactionModel> get selectedPaymentTransactions => transactions.where((t) => selectedPaymentIds.contains(t.id)).toList();
  double get selectedPaymentTotal => selectedPaymentTransactions.fold(0, (sum, t) => sum + t.amount);
  bool get canSubmitPayment => selectedPaymentIds.isNotEmpty && paymentReceivedOn.value != null;

  @override
  void onInit() {
    super.onInit();
    fetchSummaries();
    fetchTransactions();
    fetchFinanceProperties();
    chargeAmountController.addListener(_validateCharge);
    chargeDescriptionController.addListener(_validateCharge);
    ever(chargeType, (_) => _validateCharge());
    ever(billedTo, (_) => _validateCharge());
    ever(chargeProperty, (_) => _validateCharge());
    ever(chargeUnit, (_) => _validateCharge());
    ever(chargeTenant, (_) => _validateCharge());
    ever(chargeDueDate, (_) => _validateCharge());
  }

  @override
  void onClose() {
    chargeAmountController.dispose();
    chargeDescriptionController.dispose();
    reminderMessageController.dispose();
    paymentReferenceController.dispose();
    paymentAmountReceivedController.dispose();
    paymentNotesController.dispose();
    super.onClose();
  }

  void selectTab(FinanceTab tab) => selectedTab.value = tab;
  void selectHistoryTab(bool isPaid) => showPaidTab.value = isPaid;
  void openTransactionHistory() => Get.toNamed(AppRoutes.transactionHistoryScreen);

  void openTransactionDetail(TransactionModel transaction) {
    selectedTransaction.value = transaction;
    Get.toNamed(transaction.status == TransactionStatus.paid
        ? AppRoutes.paymentRecordDetailScreen
        : AppRoutes.rentDueDetailScreen);
  }

  void _validateCharge() {
    final tenantValid = billedTo.value != BilledTo.specificTenant || chargeTenant.value != null;
    canSubmitChargeRx.value = chargeType.value != null &&
        chargeProperty.value != null &&
        chargeUnit.value != null &&
        tenantValid &&
        chargeAmountController.text.trim().isNotEmpty &&
        chargeDueDate.value != null &&
        chargeDescriptionController.text.trim().isNotEmpty;
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchFinanceProperties() async {
    financeProperties.value = const [
      FinancePropertyModel(id: 'p1', name: '12 Park Lane', units: [
        UnitOptionModel(id: 'u1', label: 'Flat 1 · 1st Floor (occupied)', tenants: [TenantOptionModel(id: 't1', name: 'Sarah Johnson · Flat 2A')]),
        UnitOptionModel(id: 'u2', label: 'Flat 2A · 2nd Floor (occupied)', tenants: [TenantOptionModel(id: 't2', name: 'Priya Sharma · Flat 2B')]),
        UnitOptionModel(id: 'u3', label: 'Flat 2B · 2nd Floor (occupied)'),
        UnitOptionModel(id: 'u4', label: 'Flat 3 · 3rd Floor (occupied)'),
      ]),
      FinancePropertyModel(id: 'p2', name: '88 King Street'),
      FinancePropertyModel(id: 'p3', name: '45 Queens Road'),
      FinancePropertyModel(id: 'p4', name: '15 Victoria Ave'),
    ];
  }

  void openAddCharge() {
    chargeType.value = null;
    billedTo.value = BilledTo.allTenantsOnUnit;
    chargeProperty.value = null;
    chargeUnit.value = null;
    chargeTenant.value = null;
    chargeAmountController.clear();
    chargeDueDate.value = null;
    chargeDescriptionController.clear();
    Get.toNamed(AppRoutes.addChargeScreen);
  }

  void openPaymentReminder() {
    selectedReminderIds.clear();
    reminderMessageController.clear();
    Get.toNamed(AppRoutes.paymentReminderScreen);
  }

  void openRecordPaymentStep1() {
    selectedPaymentIds.clear();
    Get.toNamed(AppRoutes.recordPaymentSelectScreen);
  }

  void startSingleRecordPayment(TransactionModel data) {
    selectedPaymentIds..clear()..add(data.id);
    _resetPaymentDetailsForm();
    Get.toNamed(AppRoutes.recordPaymentDetailsScreen);
  }

  void proceedToPaymentDetails() {
    if (selectedPaymentIds.isEmpty) return;
    _resetPaymentDetailsForm();
    Get.toNamed(AppRoutes.recordPaymentDetailsScreen);
  }

  void _resetPaymentDetailsForm() {
    paymentReceivedOn.value = null;
    paymentMethod.value = PaymentMethod.bankTransfer;
    paymentReferenceController.clear();
    paymentAmountReceivedController.text = selectedPaymentTotal.toStringAsFixed(0);
    paymentNotesController.clear();
    receiptSentToTenant.value = false;
  }

  void togglePaymentSelection(String id) {
    selectedPaymentIds.contains(id) ? selectedPaymentIds.remove(id) : selectedPaymentIds.add(id);
  }

  void selectAllOutstandingForPayment() => selectedPaymentIds.assignAll(outstandingTransactions.map((t) => t.id));
  void clearPaymentSelection() => selectedPaymentIds.clear();

  void toggleReminderSelection(String id) {
    selectedReminderIds.contains(id) ? selectedReminderIds.remove(id) : selectedReminderIds.add(id);
  }

  void selectAllReminders() => selectedReminderIds.assignAll(outstandingTransactions.map((t) => t.id));
  void clearReminderSelection() => selectedReminderIds.clear();

  Future<void> pickPaymentReceivedDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ConstColor.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: ConstColor.titleColor,
            ),
            dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
            datePickerTheme: const DatePickerThemeData(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) paymentReceivedOn.value = picked;
  }

  Future<void> pickChargeDueDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ConstColor.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: ConstColor.titleColor,
            ),
            dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
            datePickerTheme: const DatePickerThemeData(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) chargeDueDate.value = picked;
  }

  static String formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> submitCharge() async {
    if (!canSubmitChargeRx.value) return;
    isSubmittingCharge.value = true;
    await Future.delayed(const Duration(seconds: 1));

    transactions.insert(
      0,
      TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        tenantName: billedTo.value == BilledTo.specificTenant ? (chargeTenant.value?.name ?? '-') : 'All tenants',
        propertyName: chargeProperty.value!.name,
        unitLabel: chargeUnit.value!.label.split(' · ').first,
        typeLabel: chargeType.value!.label,
        amount: double.tryParse(chargeAmountController.text.trim()) ?? 0,
        dueDateLabel: formatDate(chargeDueDate.value!),
        status: TransactionStatus.due,
        category: TransactionCategory.charge,
        extraNoteLabel: 'Due',
        invoiceNumber: 'INV-${DateTime.now().year}-${1000 + transactions.length}',
      ),
    );

    isSubmittingCharge.value = false;
    AppSnackBar.success('Charge sent successfully');
    Get.back();
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> sendPaymentReminder() async {
    if (selectedReminderIds.isEmpty) return;
    isSendingReminder.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isSendingReminder.value = false;
    AppSnackBar.success('Reminder sent to ${selectedReminderIds.length} tenant(s)');
    Get.back();
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> submitRecordPayment() async {
    if (!canSubmitPayment) return;
    isSubmittingPayment.value = true;
    await Future.delayed(const Duration(seconds: 1));

    for (final id in selectedPaymentIds.toList()) {
      final index = transactions.indexWhere((t) => t.id == id);
      if (index != -1) {
        transactions[index] = transactions[index].copyWith(
          status: TransactionStatus.paid,
          paidOnLabel: formatDate(paymentReceivedOn.value!),
          paymentMethodLabel: paymentMethod.value.label,
          referenceLabel: paymentReferenceController.text.trim().isEmpty ? null : paymentReferenceController.text.trim(),
        );
      }
    }

    selectedPaymentIds.clear();
    isSubmittingPayment.value = false;
    Get.toNamed(AppRoutes.paymentSuccessScreen);
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchSummaries() async {
    summaryByTab.value = {
      FinanceTab.all: const FinanceSummaryModel(
        collectedAmount: 2050, expectedAmount: 11265, collectedPercentage: 18, paidCount: 23, outstandingCount: 6,
        stats: [
          FinanceStatItem(label: 'due soon', value: '£7,365', color: ConstColor.contractorIconColor, bg: ConstColor.contractorIconBg),
          FinanceStatItem(label: '1 overdue', value: '£1,850', color: ConstColor.errorColor, bg: ConstColor.errorBg),
          FinanceStatItem(label: 'outstanding', value: '£9,215', color: ConstColor.bodyColor, bg: ConstColor.dividerColor),
        ],
      ),
      FinanceTab.rent: const FinanceSummaryModel(
        collectedAmount: 2050, expectedAmount: 11265, collectedPercentage: 18, paidCount: 23, outstandingCount: 5,
        stats: [
          FinanceStatItem(label: 'due soon', value: '£7,280', color: ConstColor.contractorIconColor, bg: ConstColor.contractorIconBg),
          FinanceStatItem(label: '1 overdue', value: '£1,850', color: ConstColor.errorColor, bg: ConstColor.errorBg),
          FinanceStatItem(label: 'outstanding', value: '£9,130', color: ConstColor.bodyColor, bg: ConstColor.dividerColor),
        ],
      ),
      FinanceTab.charges: const FinanceSummaryModel(
        collectedAmount: 0, expectedAmount: 85, collectedPercentage: 0, paidCount: 0, outstandingCount: 1,
        stats: [
          FinanceStatItem(label: 'due soon', value: '£85', color: ConstColor.contractorIconColor, bg: ConstColor.contractorIconBg),
          FinanceStatItem(label: 'collected', value: '0%', color: ConstColor.tenantIconColor, bg: ConstColor.tenantIconBg),
          FinanceStatItem(label: 'outstanding', value: '£85', color: ConstColor.bodyColor, bg: ConstColor.dividerColor),
        ],
      ),
    };
  }

  // TODO: Replace with Dio API call once backend endpoint is ready.
  Future<void> fetchTransactions() async {
    transactions.value = [
      const TransactionModel(id: '1', tenantName: 'David Wilson', propertyName: '45 Queens Road', unitLabel: 'Flat 1A', typeLabel: 'Rent', amount: 1850, dueDateLabel: 'Jul 2026', status: TransactionStatus.overdue, category: TransactionCategory.rent, extraNoteLabel: '75 days overdue', invoiceNumber: 'INV-2026-1047'),
      const TransactionModel(id: '2', tenantName: 'Michael Lee', propertyName: '15 Victoria Ave', unitLabel: 'Flat 2A', typeLabel: 'Rent', amount: 1950, dueDateLabel: 'Jul 2026', status: TransactionStatus.pending, category: TransactionCategory.rent, extraNoteLabel: 'Due', invoiceNumber: 'INV-2026-1045'),
      const TransactionModel(id: '3', tenantName: 'Sarah Johnson', propertyName: '12 Park Lane', unitLabel: 'Flat 2A', typeLabel: 'Repair', amount: 85, dueDateLabel: 'Jul 2026', status: TransactionStatus.due, category: TransactionCategory.charge, extraNoteLabel: 'Due', invoiceNumber: 'INV-2026-1050'),
      const TransactionModel(id: '4', tenantName: 'Sarah Johnson', propertyName: '12 Park Lane', unitLabel: 'Flat 2A', typeLabel: 'Rent', amount: 2450, dueDateLabel: 'Jul 2026', status: TransactionStatus.due, category: TransactionCategory.rent, extraNoteLabel: 'Due', invoiceNumber: 'INV-2026-1051'),
      const TransactionModel(id: '5', tenantName: 'Priya Sharma', propertyName: '12 Park Lane', unitLabel: 'Flat 2B', typeLabel: 'Rent', amount: 2200, dueDateLabel: 'Jul 2026', status: TransactionStatus.due, category: TransactionCategory.rent, extraNoteLabel: 'Due', invoiceNumber: 'INV-2026-1052'),
      const TransactionModel(id: '6', tenantName: 'Mark Davis', propertyName: '88 King Street', unitLabel: 'Room 3', typeLabel: 'Rent', amount: 680, dueDateLabel: 'Jul 2026', status: TransactionStatus.due, category: TransactionCategory.rent, extraNoteLabel: 'Due', invoiceNumber: 'INV-2026-1053'),
      const TransactionModel(id: '7', tenantName: 'Emma Thompson', propertyName: '12 Park Lane', unitLabel: 'Flat 1', typeLabel: 'Sept 2026 rent', amount: 1400, dueDateLabel: 'Sept 1, 2026', status: TransactionStatus.paid, category: TransactionCategory.rent, invoiceNumber: 'INV-2026-1062', paidOnLabel: 'Sep 1, 2026', paymentMethodLabel: 'Direct Debit', referenceLabel: 'DD-PL01-SEP'),
    ];
  }

  void cancelBill(String id) {
    ConfirmActionDialog.show(
      title: 'Cancel Bill',
      message: 'This will remove the bill and cannot be undone.',
      confirmLabel: 'Cancel bill',
      onConfirm: () {
        // TODO: Replace with Dio API call once backend endpoint is ready.
        transactions.removeWhere((t) => t.id == id);
        selectedTransaction.value = null;
        Get.back();
        AppSnackBar.success('Bill cancelled');
      },
    );
  }

  void undoPayment(String id) {
    ConfirmActionDialog.show(
      title: 'Undo Payment',
      message: 'This will mark the bill as unpaid again.',
      confirmLabel: 'Undo',
      onConfirm: () {
        // TODO: Replace with Dio API call once backend endpoint is ready.
        Get.back();
        AppSnackBar.success('Payment undone');
      },
    );
  }

  Future<void> downloadPaymentReceipt(TransactionModel data) {
    return ReceiptPdfGenerator.generateAndShare(
      documentTitle: 'Payment Receipt - ${data.invoiceNumber}',
      heading: ConstString.amountPaid,
      amountLabel: '£${data.amount.toStringAsFixed(0)}',
      rows: [
        MapEntry(ConstString.tenant, data.tenantName),
        MapEntry(ConstString.property, data.propertyName),
        MapEntry(ConstString.unit, data.unitLabel),
        MapEntry(ConstString.type, data.typeLabel),
        MapEntry(ConstString.dueDate, data.dueDateLabel),
        MapEntry(ConstString.invoiceHash, data.invoiceNumber),
        if (data.paidOnLabel != null) MapEntry(ConstString.paidOn, data.paidOnLabel!),
        if (data.paymentMethodLabel != null) MapEntry(ConstString.paymentMethod, data.paymentMethodLabel!),
        if (data.referenceLabel != null) MapEntry(ConstString.reference, data.referenceLabel!),
      ],
      footerNote: 'Generated by Landlord HQ',
    );
  }

  Future<void> downloadRentDuePdf(TransactionModel data) {
    return ReceiptPdfGenerator.generateAndShare(
      documentTitle: 'Rent Invoice - ${data.invoiceNumber}',
      heading: ConstString.amountDue,
      amountLabel: '£${data.amount.toStringAsFixed(0)}',
      rows: [
        MapEntry(ConstString.tenant, data.tenantName),
        MapEntry(ConstString.property, data.propertyName),
        MapEntry(ConstString.unit, data.unitLabel),
        MapEntry(ConstString.type, data.typeLabel),
        MapEntry(ConstString.dueDate, data.dueDateLabel),
        MapEntry(ConstString.invoiceHash, data.invoiceNumber),
      ],
      footerNote: 'Generated by Landlord HQ',
    );
  }
}