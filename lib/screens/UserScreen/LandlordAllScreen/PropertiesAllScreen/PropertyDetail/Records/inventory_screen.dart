import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/CustomDropdownField/custom_dropdown_field.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import 'controller/inventory_controller.dart';
import 'dialog/inventory_dialogs.dart';
import 'model/asset_record_model.dart';
import 'model/inventory_model.dart';

class InventoryScreen extends GetView<InventoryController> {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: ConstString.inventory,
        actions: [AppBarTextAction(label: ConstString.addRoom, icon: Icons.add_rounded, onTap: () => InventoryDialogs.showRoomForm(controller))],
      ),
      body: Obx(
            () => ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            CustomDropdownField<FlatFilterModel>(
              label: ConstString.selectFlatArea,
              value: controller.selectedFlatFilter.value,
              items: controller.flatFilters.map((f) => DropdownMenuItem(value: f, child: CustomText(title: f.label, textSize: 14.sp))).toList(),
              onChanged: controller.selectFlatFilter,
            ),
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(title: '${controller.selectedFlatFilter.value?.label.split(' · ').first ?? ''} ${ConstString.roomChecklists}', textSize: 13.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor, maxLine: 1),
                GestureDetector(
                  onTap: () => InventoryDialogs.showRoomForm(controller),
                  child: CustomText(title: '+ ${ConstString.addRoom}', textSize: 12.sp, fontWeight: FontWeight.w500, textColor: ConstColor.primaryColor),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            ...controller.rooms.map((r) => Padding(padding: EdgeInsets.only(bottom: 10.h), child: _RoomTile(room: r))),
          ],
        ),
      ),
    );
  }
}

class _RoomTile extends StatelessWidget {
  const _RoomTile({required this.room});
  final RoomModel room;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InventoryController>();
    return GestureDetector(
      onTap: () => controller.openRoomItems(room),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14.r)),
        child: Row(
          children: [
            Icon(_roomIcon(room.name), size: 20.sp, color: ConstColor.primaryColor),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title: room.name, textSize: 13.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
                  CustomText(
                    title: [if (room.sizeLabel.isNotEmpty) room.sizeLabel, '${room.items.length} ${ConstString.itemsSuffix}'].join(' · '),
                    textSize: 11.sp,
                    textColor: ConstColor.bodyColor,
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert_rounded, size: 18.sp, color: ConstColor.bodyColor),
              onSelected: (v) {
                if (v == 'edit') InventoryDialogs.showRoomForm(controller, room: room);
                if (v == 'delete') InventoryDialogs.confirmDeleteRoom(controller, room.id);
              },
              itemBuilder: (context) => [
                PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit_outlined, size: 16.sp, color: ConstColor.titleColor), SizedBox(width: 8.w), CustomText(title: ConstString.edit, textSize: 13.sp)])),
                PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete_outline_rounded, size: 16.sp, color: ConstColor.errorColor), SizedBox(width: 8.w), CustomText(title: ConstString.delete, textSize: 13.sp, textColor: ConstColor.errorColor)])),
              ],
            ),
            Icon(Icons.chevron_right_rounded, size: 18.sp, color: ConstColor.bodyColor),
          ],
        ),
      ),
    );
  }

  IconData _roomIcon(String name) {
    final n = name.toLowerCase();
    if (n.contains('kitchen')) return Icons.kitchen_outlined;
    if (n.contains('living')) return Icons.weekend_outlined;
    if (n.contains('bed')) return Icons.bed_outlined;
    if (n.contains('bath')) return Icons.bathtub_outlined;
    if (n.contains('hall')) return Icons.door_front_door_outlined;
    return Icons.meeting_room_outlined;
  }
}