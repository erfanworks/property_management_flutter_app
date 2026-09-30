// lib/screens/UserScreen/LandlordAllScreen/PropertiesAllScreen/PropertyDetail/UnitDetail/unit_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../../../../../../widget/CustomStatusChip/custom_status_chip.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../../../../../../widget/DetailRow/detail_row.dart';
import '../widget/nav_list_tile.dart';
import 'controller/unit_detail_controller.dart';
import 'model/unit_profile_model.dart';

class UnitDetailScreen extends GetView<UnitDetailController> {
  const UnitDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final unit = controller.unit.value;
      if (unit == null) return const Scaffold(body: SizedBox.shrink());

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(title: unit.name, subtitle: unit.propertyName),
        body: Column(
          children: [
            _UnitTabBar(
              selectedIndex: controller.selectedTabIndex.value,
              onChanged: controller.selectTab,
            ),
            Expanded(
              child: switch (controller.selectedTabIndex.value) {
                0 => _OverviewTab(unit: unit),
                1 => _TenantTab(unit: unit),
                2 => _PaymentsTab(unit: unit),
                _ => const _PhotosTab(),
              },
            ),
          ],
        ),
      );
    });
  }
}

class _UnitTabBar extends StatelessWidget {
  const _UnitTabBar({required this.selectedIndex, required this.onChanged});

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  static final _tabs = [
    (icon: Icons.grid_view_rounded, label: ConstString.overview),
    (icon: Icons.group, label: ConstString.tenant),
    (icon: Icons.payments_outlined, label: ConstString.payments),
    (icon: Icons.photo_library_outlined, label: ConstString.photos),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            offset: Offset(0, 2.h),
            blurRadius: 4.r,
          ),
        ],
      ),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = index == selectedIndex;
          final tab = _tabs[index];
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: Container(
                padding: EdgeInsets.only(top: 10.h),
                child: Column(
                  children: [
                    Icon(
                      tab.icon,
                      size: 18.sp,
                      color: isSelected
                          ? ConstColor.primaryColor
                          : ConstColor.bodyColor,
                    ),
                    SizedBox(height: 2.h),
                    CustomText(
                      title: tab.label,
                      textSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      textColor: isSelected
                          ? ConstColor.primaryColor
                          : ConstColor.bodyColor,
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      height: 3.5.h,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ConstColor.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(4.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  const _OverviewTab({required this.unit});

  final UnitProfileModel unit;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UnitDetailController>();
    return ListView(
      padding: EdgeInsets.all(16.r),
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(12),
                blurRadius: 8.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: Stack(
                  children: [
                    unit.photoUrls.isNotEmpty
                        ? AppImage(
                            filePath: unit.photoUrls[unit.coverPhotoIndex],
                            width: double.infinity,
                            height: 160.h,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: double.infinity,
                            height: 160.h,
                            color: ConstColor.dividerColor,
                            child: Icon(
                              Icons.image_outlined,
                              color: ConstColor.bodyColor,
                              size: 32.sp,
                            ),
                          ),
                    Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: CustomStatusChip(
                        label: unit.isOccupied
                            ? ConstString.occupied
                            : ConstString.vacant,
                        color: unit.isOccupied
                            ? ConstColor.tenantIconColor
                            : ConstColor.contractorIconColor,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: unit.name,
                      textSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      textColor: ConstColor.titleColor,
                    ),
                    SizedBox(height: 2.h),
                    CustomText(
                      title:
                          '${unit.floorLabel} · ${unit.beds} Bed · ${unit.baths} Bath · ${unit.sqft} sq ft · ${unit.furnished.label}',
                      textSize: 12.sp,
                      textColor: ConstColor.bodyColor,
                    ),
                    SizedBox(height: 14.h),
                    DetailRow(
                      icon: Icons.credit_card_outlined,
                      label: ConstString.monthlyRentLabel,
                      value: '£${unit.monthlyRent.toStringAsFixed(0)}/mo',
                    ),
                    DetailRow(
                      icon: Icons.shield_outlined,
                      label: ConstString.depositHeld,
                      value:
                          '£${unit.depositHeld.toStringAsFixed(0)} · ${unit.depositScheme}',
                    ),
                    DetailRow(
                      icon: Icons.event_note_outlined,
                      label: 'Lease term',
                      value: '${unit.leaseStartLabel} – ${unit.leaseEndLabel}',
                    ),
                    DetailRow(
                      icon: Icons.description_outlined,
                      label: 'Agreement',
                      value: unit.agreementType,
                    ),
                    DetailRow(
                      icon: Icons.schedule_outlined,
                      label: 'Payment schedule',
                      value: unit.paymentScheduleLabel,
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.h),
        NavListTile(
          icon: Icons.vpn_key_outlined,
          iconColor: ConstColor.contractorIconColor,
          iconBg: ConstColor.contractorIconBg,
          title: 'KEY HANDOVER',
          subtitle: '${unit.keySets.length} Key Sets',
          onTap: controller.openKeysAccess,
        ),
      ],
    );
  }
}

class _TenantTab extends StatelessWidget {
  const _TenantTab({required this.unit});

  final UnitProfileModel unit;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.r),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              title: 'Members · ${unit.members.length}',
              textSize: 14.sp,
              fontWeight: FontWeight.w700,
              textColor: ConstColor.titleColor,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: ConstColor.infoBg,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: ConstColor.primaryColor.withAlpha(30))
              ),
              child: CustomText(
                title:
                    '${unit.leaseStartLabel} – ${unit.leaseEndLabel} · Lease',
                textSize: 10.sp,
                fontWeight: FontWeight.w600,
                textColor: ConstColor.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        ...unit.members.map(
          (m) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: ConstColor.titleColor.withAlpha(30))
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: AppImage(
                      url: m.avatarUrl,
                      width: 40.r,
                      height: 40.r,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              title: m.name,
                              textSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              textColor: ConstColor.titleColor,
                            ),
                            if (m.roleLabel == 'Lead Member') ...[
                              SizedBox(width: 6.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: ConstColor.infoBg,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: CustomText(
                                  title: m.roleLabel,
                                  textSize: 9.sp,
                                  fontWeight: FontWeight.w600,
                                  textColor: ConstColor.primaryColor,
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (m.roleLabel != 'Lead Member')
                          CustomText(
                            title: m.roleLabel,
                            textSize: 11.sp,
                            textColor: ConstColor.bodyColor,
                          ),
                        if (m.keySetsSummary != null)
                          CustomText(
                            title: m.keySetsSummary!,
                            textSize: 11.sp,
                            textColor: ConstColor.bodyColor,
                          ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18.sp,
                    color: ConstColor.bodyColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          // TODO: link to Invite Tenant flow once tenant-unit linking confirmed
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: ConstColor.primaryColor.withAlpha(80))
            ),
            alignment: Alignment.center,
            child: CustomText(
              title: '+ Invite member',
              textSize: 13.sp,
              fontWeight: FontWeight.w600,
              textColor: ConstColor.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _PaymentsTab extends StatelessWidget {
  const _PaymentsTab({required this.unit});

  final UnitProfileModel unit;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.r),
      children: [
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: ConstColor.titleColor.withAlpha(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: 'CONTRACTED RENT',
                textSize: 10.sp,
                fontWeight: FontWeight.w600,
                textColor: ConstColor.bodyColor,
                letterSpacing: 0.4,
              ),
              SizedBox(height: 4.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  CustomText(
                    title: '£${unit.contractedRent.toStringAsFixed(0)}',
                    textSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    textColor: ConstColor.titleColor,
                  ),
                  CustomText(
                    title: ' / month',
                    textSize: 11.sp,
                    textColor: ConstColor.bodyColor,
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: ConstColor.screenBackground,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: ConstColor.titleColor.withAlpha(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: 'Collected (YTD)',
                            textSize: 10.sp,
                            textColor: ConstColor.bodyColor,
                          ),
                          CustomText(
                            title: '£${unit.collectedYtd.toStringAsFixed(0)}',
                            textSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            textColor: ConstColor.titleColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: ConstColor.screenBackground,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: ConstColor.titleColor.withAlpha(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: 'Next due',
                            textSize: 10.sp,
                            textColor: ConstColor.bodyColor,
                          ),
                          CustomText(
                            title: '£${unit.nextDueAmount.toStringAsFixed(2)}',
                            textSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            textColor: ConstColor.titleColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        CustomText(
          title: 'Monthly payment ledger',
          textSize: 13.sp,
          fontWeight: FontWeight.w700,
          textColor: ConstColor.titleColor,
        ),
        CustomText(
          title: 'Rent and charges for this unit',
          textSize: 11.sp,
          textColor: ConstColor.bodyColor,
        ),
        SizedBox(height: 10.h),
        ...unit.paymentLedger.map(
          (e) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: e.monthLabel,
                          textSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          textColor: ConstColor.titleColor,
                        ),
                        CustomText(
                          title: '${e.dateLabel} · ${e.typeLabel}',
                          textSize: 11.sp,
                          textColor: ConstColor.bodyColor,
                        ),
                      ],
                    ),
                  ),
                  CustomText(
                    title: '£${e.amount.toStringAsFixed(0)}',
                    textSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    textColor: e.isPaid
                        ? ConstColor.titleColor
                        : ConstColor.contractorIconColor,
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    e.isPaid
                        ? Icons.download_outlined
                        : Icons.chevron_right_rounded,
                    size: 16.sp,
                    color: ConstColor.bodyColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PhotosTab extends StatelessWidget {
  const _PhotosTab();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UnitDetailController>();
    return Obx(() {
      final unit = controller.unit.value!;
      return ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.w,
              childAspectRatio: 1.1,
            ),
            itemCount: unit.photoUrls.length,
            itemBuilder: (context, index) {
              final isCover = index == unit.coverPhotoIndex;
              return ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AppImage(
                      filePath: unit.photoUrls[index],
                      fit: BoxFit.cover,
                    ),
                    if (isCover)
                      Positioned(
                        top: 6.h,
                        left: 6.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(160),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: CustomText(
                            title: 'Cover',
                            textSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            textColor: Colors.white,
                          ),
                        ),
                      )
                    else
                      Positioned(
                        top: 4.h,
                        right: 4.w,
                        child: GestureDetector(
                          onTap: () =>
                              controller.setCoverPhoto(index, forForm: false),
                          child: CircleAvatar(
                            radius: 13.r,
                            backgroundColor: Colors.black45,
                            child: Icon(
                              Icons.star_border_rounded,
                              size: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: () => controller.addUnitPhoto(forForm: false),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ConstColor.primaryColor.withAlpha(60),
                ),
                borderRadius: BorderRadius.circular(12.r),
                color: ConstColor.infoBg,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    color: ConstColor.primaryColor,
                    size: 18.sp,
                  ),
                  SizedBox(width: 6.w),
                  CustomText(
                    title: 'Add more photos',
                    textSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    textColor: ConstColor.primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h),
          CustomText(
            title:
                'Tap the star on a thumbnail to set the cover for Overview and unit lists.',
            textSize: 11.sp,
            textColor: ConstColor.bodyColor,
            textAlign: TextAlign.center,
            maxLine: 2,
          ),
        ],
      );
    });
  }
}
