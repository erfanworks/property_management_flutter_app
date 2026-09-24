// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/tenant_notes_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../controller/property_detail_controller.dart';
import '../model/property_detail_model.dart';

class TenantNotesScreen extends GetView<PropertyDetailController> {
  const TenantNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: ConstString.notes,
        actions: [
          Center(
            child: GestureDetector(
              onTap: controller.openAddNote,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: ConstColor.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_rounded,
                      size: 16.sp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4.w),
                    CustomText(
                      title: ConstString.addNote,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => ListView.separated(
          padding: EdgeInsets.all(16.r),
          itemCount: controller.tenantNotesRx.length,
          separatorBuilder: (_, index) => SizedBox(height: 10.h),
          itemBuilder: (context, index) => _NoteTile(
            data: controller.tenantNotesRx[index],
            onDelete: () => controller.confirmDeleteNote(
              controller.tenantNotesRx[index].id,
            ),
          ),
        ),
      ),
    );
  }
}

class _NoteTile extends StatelessWidget {
  const _NoteTile({required this.data, required this.onDelete});

  final TenantNoteModel data;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: ConstColor.titleColor.withAlpha(30))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: data.text,
                  textSize: 13.sp,
                  textColor: ConstColor.titleColor,
                  maxLine: 4,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  title: '${data.dateLabel} · ${data.authorLabel}',
                  textSize: 11.sp,
                  textColor: ConstColor.bodyColor,
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            icon: Icon(
              Icons.more_horiz_rounded,
              size: 18.sp,
              color: ConstColor.bodyColor,
            ),
            onSelected: (v) {
              if (v == 'delete') onDelete();
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined, size: 16.sp),
                    SizedBox(width: 8.w),
                    CustomText(title: ConstString.edit, textSize: 13.sp),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline_rounded,
                      size: 16.sp,
                      color: ConstColor.errorColor,
                    ),
                    SizedBox(width: 8.w),
                    CustomText(
                      title: 'Delete',
                      textSize: 13.sp,
                      textColor: ConstColor.errorColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
