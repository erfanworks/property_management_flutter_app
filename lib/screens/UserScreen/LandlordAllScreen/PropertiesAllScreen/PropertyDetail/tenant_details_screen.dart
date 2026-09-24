// lib/screens/UserScreen/LandlordAllScreen/PropertyDetail/tenant_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:imusa04_landlord_app/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/widget/nav_list_tile.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomIconBadge/custom_icon_badge.dart';
import '../../../../../widget/CustomStatusChip/custom_status_chip.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import '../../HomeTabAllScreen/Finance/payment_record_detail_screen.dart';
import 'controller/property_detail_controller.dart';

class TenantDetailsScreen extends GetView<PropertyDetailController> {
  const TenantDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final data = controller.selectedTenant.value;
      if (data == null) return const Scaffold(body: SizedBox.shrink());

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: ConstString.tenantDetails),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Container(
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(borderRadius: BorderRadius.circular(26.r), child: AppImage(url: data.avatarUrl, width: 52.r, height: 52.r, fit: BoxFit.cover)),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(title: data.fullName, textSize: 16.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                            SizedBox(height: 4.h),
                            if (data.isActive) CustomStatusChip(label: ConstString.activeTenant, color: ConstColor.tenantIconColor, backgroundColor: ConstColor.tenantIconBg),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(Icons.home_outlined, size: 12.sp, color: ConstColor.bodyColor),
                                SizedBox(width: 4.w),
                                Expanded(child: CustomText(title: '${data.unitLabel}, ${data.propertyName}', textSize: 11.sp, textColor: ConstColor.bodyColor, maxLine: 1)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      Expanded(child: _QuickAction(icon: Icons.call_outlined, label: ConstString.call, onTap: () => controller.notifyComingSoon(ConstString.call))),
                      Expanded(child: _QuickAction(icon: Icons.chat_bubble_outline_rounded, label: ConstString.message, onTap: () => controller.notifyComingSoon(ConstString.message))),
                      Expanded(child: _QuickAction(icon: Icons.receipt_long_outlined, label: ConstString.viewRent, onTap: () => controller.notifyComingSoon(ConstString.viewRent))),
                      Expanded(child: _QuickAction(icon: Icons.description_outlined, label: ConstString.viewLease, onTap: () => controller.notifyComingSoon(ConstString.viewLease))),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
              child: Column(
                children: [
                  DetailRow(label: ConstString.fullName, value: data.fullName),
                  DetailRow(label: ConstString.dateOfBirth, value: data.dateOfBirth),
                  DetailRow(label: ConstString.nid, value: data.nid),
                  DetailRow(label: ConstString.email, value: data.email),
                  DetailRow(label: ConstString.phone, value: data.phone),
                  DetailRow(label: ConstString.emergencyContact, value: data.emergencyContact),
                  DetailRow(label: ConstString.address, value: data.address),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: GestureDetector(
                      onTap: () => controller.notifyComingSoon(ConstString.nid),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(title: ConstString.nid, textSize: 13.sp, textColor: ConstColor.bodyColor),
                          Row(children: [
                            CustomText(title: data.nidProofFileName, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.primaryColor),
                            Icon(Icons.chevron_right_rounded, size: 16.sp, color: ConstColor.bodyColor),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            NavListTile(icon: Icons.savings_outlined, iconColor: ConstColor.primaryColor, iconBg: ConstColor.infoBg, title: ConstString.deposit, subtitle: data.depositSummary, onTap: () => controller.notifyComingSoon(ConstString.deposit)),
            SizedBox(height: 8.h),
            NavListTile(icon: Icons.vpn_key_outlined, iconColor: ConstColor.contractorIconColor, iconBg: ConstColor.contractorIconBg, title: ConstString.keys, subtitle: data.keysSummary, onTap: () => controller.notifyComingSoon(ConstString.keys)),
            SizedBox(height: 8.h),
            NavListTile(icon: Icons.apartment_rounded, iconColor: ConstColor.purpleColor, iconBg: ConstColor.purpleBg, title: ConstString.buildingInformation, subtitle: data.buildingInfoSummary, onTap: () => controller.notifyComingSoon(ConstString.buildingInformation)),
            SizedBox(height: 8.h),
            NavListTile(icon: Icons.folder_outlined, iconColor: ConstColor.tenantIconColor, iconBg: ConstColor.tenantIconBg, title: ConstString.documents, subtitle: '${data.documentsCount} files uploaded', onTap: () => controller.notifyComingSoon(ConstString.documents)),
            SizedBox(height: 8.h),
            NavListTile(
              icon: Icons.sticky_note_2_outlined,
              iconColor: ConstColor.errorColor,
              iconBg: ConstColor.errorBg,
              title: ConstString.notes,
              subtitle: data.latestNoteSummary != null ? '${data.latestNoteSummary} · ${data.latestNoteDateLabel}' : null,
              onTap: () => controller.notifyComingSoon(ConstString.notes),
            ),
          ],
        ),
      );
    });
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CustomIconBadge(icon: icon, iconColor: ConstColor.primaryColor, backgroundColor: ConstColor.infoBg, size: 36),
          SizedBox(height: 4.h),
          CustomText(title: label, textSize: 10.sp, fontWeight: FontWeight.w500, textColor: ConstColor.titleColor, maxLine: 1),
        ],
      ),
    );
  }
}