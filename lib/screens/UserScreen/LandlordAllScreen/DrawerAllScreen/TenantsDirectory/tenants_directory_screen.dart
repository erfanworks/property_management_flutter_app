// lib/screens/UserScreen/LandlordAllScreen/TenantsDirectory/tenants_directory_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomDropdownField/custom_dropdown_field.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import 'controller/tenants_directory_controller.dart';
import 'model/tenant_directory_model.dart';

class TenantsDirectoryScreen extends GetView<TenantsDirectoryController> {
  const TenantsDirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(title: ConstString.tenants),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            CustomTextFormField(
              hintText: CustomText(title: ConstString.searchTenantsHint, textColor: ConstColor.bodyColor, textSize: 13.sp),
              prefixIcon: Icon(Icons.search_rounded, color: ConstColor.bodyColor, size: 20.sp),
              onChanged: controller.applySearch,
            ),
            SizedBox(height: 8.h),
            Obx(
                  () => Row(
                children: [
                  Expanded(
                    child: CustomDropdownField<String?>(
                      value: controller.selectedProperty.value,
                      hintText: ConstString.allProperties,
                      items: [
                        DropdownMenuItem(value: null, child: CustomText(title: ConstString.allProperties, textSize: 13.sp)),
                        ...controller.properties.map((p) => DropdownMenuItem(value: p, child: CustomText(title: p, textSize: 13.sp))),
                      ],
                      onChanged: controller.selectProperty,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomDropdownField<String?>(
                      value: controller.selectedFlat.value,
                      hintText: ConstString.allFlats,
                      items: [
                        DropdownMenuItem(value: null, child: CustomText(title: ConstString.allFlats, textSize: 13.sp)),
                        ...controller.flats.map((f) => DropdownMenuItem(value: f, child: CustomText(title: f, textSize: 13.sp))),
                      ],
                      onChanged: controller.selectFlat,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: Obx(
                    () => ListView.separated(
                  itemCount: controller.filteredTenants.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    final t = controller.filteredTenants[index];
                    return _TenantTile(data: t, onTap: () => controller.openTenant(t));
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

class _TenantTile extends StatelessWidget {
  const _TenantTile({required this.data, required this.onTap});
  final TenantDirectoryModel data;
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
            ClipRRect(borderRadius: BorderRadius.circular(20.r), child: AppImage(url: data.avatarUrl, width: 40.r, height: 40.r, fit: BoxFit.cover)),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title: data.name, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor),
                  CustomText(title: '${data.unitLabel} · ${data.propertyName}', textSize: 11.sp, textColor: ConstColor.bodyColor),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, size: 18.sp, color: ConstColor.bodyColor),
          ],
        ),
      ),
    );
  }
}