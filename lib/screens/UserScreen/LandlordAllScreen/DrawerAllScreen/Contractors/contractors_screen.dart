// lib/screens/UserScreen/LandlordAllScreen/Contractors/contractors_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import '../../HomeTabAllScreen/Maintenance/model/contractor_model.dart';
import 'controller/contractors_controller.dart';

class ContractorsScreen extends GetView<ContractorsController> {
  const ContractorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: ConstString.contractors,
        actions: [AppBarTextAction(label: ConstString.invite, icon: Icons.person_add_alt_1_rounded, onTap: controller.openInvite)],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            CustomTextFormField(
              hintText: CustomText(title: ConstString.searchContractorsHint, textColor: ConstColor.bodyColor, textSize: 13.sp),
              prefixIcon: Icon(Icons.search_rounded, color: ConstColor.bodyColor, size: 20.sp),
              onChanged: controller.applySearch,
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: Obx(
                    () => ListView.separated(
                  itemCount: controller.filteredContractors.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    final c = controller.filteredContractors[index];
                    return _ContractorTile(data: c, onTap: () => controller.openDetail(c));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContractorTile extends StatelessWidget {
  const _ContractorTile({required this.data, required this.onTap});
  final ContractorModel data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(20.r), child: AppImage(url: data.avatarUrl, width: 40.r, height: 40.r, fit: BoxFit.cover)),
                if (data.isOnline)
                  Positioned(bottom: 0, right: 0, child: Container(width: 10.r, height: 10.r, decoration: BoxDecoration(color: ConstColor.tenantIconColor, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5)))),
              ],
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Row(
                children: [
                  Flexible(child: CustomText(title: data.name, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor, maxLine: 1)),
                  if (data.isVerified) ...[SizedBox(width: 4.w), Icon(Icons.verified_rounded, size: 14.sp, color: ConstColor.primaryColor)],
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(color: data.roleColor.withAlpha(30), borderRadius: BorderRadius.circular(20.r)),
              child: CustomText(title: data.roleLabel, textSize: 10.sp, fontWeight: FontWeight.w600, textColor: data.roleColor),
            ),
            SizedBox(width: 8.w),
            if (data.rating != null) ...[Icon(Icons.star_rounded, size: 14.sp, color: Colors.amber), CustomText(title: '${data.rating}', textSize: 12.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor)],
            SizedBox(width: 6.w),
            Icon(Icons.chat_bubble_outline_rounded, size: 18.sp, color: ConstColor.primaryColor),
          ],
        ),
      ),
    );
  }
}