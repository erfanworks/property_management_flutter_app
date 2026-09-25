// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/Records/room_items_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import 'controller/inventory_controller.dart';
import 'dialog/inventory_dialogs.dart';
import 'model/inventory_model.dart';

class RoomItemsScreen extends GetView<InventoryController> {
  const RoomItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final room = controller.selectedRoom.value;
      if (room == null) return const Scaffold(body: SizedBox.shrink());

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: ConstString.inventory),
        body: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(title: room.name, textSize: 15.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                  if (room.sizeLabel.isNotEmpty) CustomText(title: room.sizeLabel, textSize: 12.sp, textColor: ConstColor.bodyColor),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(title: ConstString.itemsAndFixtures, textSize: 11.sp, fontWeight: FontWeight.w600, textColor: ConstColor.bodyColor, letterSpacing: 0.4),
                GestureDetector(
                  onTap: () => InventoryDialogs.showItemForm(controller),
                  child: CustomText(title: '+ ${ConstString.addItem}', textSize: 12.sp, fontWeight: FontWeight.w500, textColor: ConstColor.primaryColor),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ...room.items.map((item) => Padding(padding: EdgeInsets.only(bottom: 10.h), child: _ItemTile(item: item))),
          ],
        ),
      );
    });
  }
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({required this.item});
  final InventoryItemModel item;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InventoryController>();
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: item.photoPath != null
                ? AppImage(path: item.photoPath, width: 36.r, height: 36.r, fit: BoxFit.cover)
                : Container(width: 36.r, height: 36.r, color: ConstColor.dividerColor, child: Icon(Icons.image_outlined, size: 16.sp, color: ConstColor.bodyColor)),
          ),
          SizedBox(width: 12.w),
          Expanded(child: CustomText(title: item.name, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.titleColor)),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert_rounded, size: 18.sp, color: ConstColor.bodyColor),
            onSelected: (v) {
              if (v == 'edit') InventoryDialogs.showItemForm(controller, item: item);
              if (v == 'delete') InventoryDialogs.confirmDeleteItem(controller, item.id);
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit_outlined, size: 16.sp, color: ConstColor.titleColor), SizedBox(width: 8.w), CustomText(title: ConstString.edit, textSize: 13.sp)])),
              PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete_outline_rounded, size: 16.sp, color: ConstColor.errorColor), SizedBox(width: 8.w), CustomText(title: ConstString.delete, textSize: 13.sp, textColor: ConstColor.errorColor)])),
            ],
          ),
        ],
      ),
    );
  }
}