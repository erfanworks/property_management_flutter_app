// lib/screens/UserScreen/LandlordAllScreen/PropertyDetail/property_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../models/property_model.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomIconBadge/custom_icon_badge.dart';
import '../../../../../widget/CustomSegmentedToggle/custom_segmented_toggle.dart';
import '../../../../../widget/CustomStatusChip/custom_status_chip.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import '../Properties/controller/properties_controller.dart';
import '../Properties/model/properties_filter.dart';
import 'Records/controller/records_controller.dart';
import 'Records/model/records_model.dart';
import 'controller/property_detail_controller.dart';
import 'model/property_detail_model.dart';
import 'widget/detail_row.dart';
import 'widget/nav_list_tile.dart';

class PropertyDetailScreen extends GetView<PropertyDetailController> {
  const PropertyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final property = controller.property.value;
      if (property == null) return const Scaffold(body: SizedBox.shrink());

      return Scaffold(
        backgroundColor: ConstColor.screenBackground,
        appBar: GlobalAppBar(
          title: property.name,
          actions: controller.selectedTabIndex.value == 1
              ? [
                  AppBarTextAction(
                    label: ConstString.invite,
                    icon: Icons.person_add_alt_1_rounded,
                    onTap: controller.openInviteTenant,
                  ),
                ]
              : null,
        ),
        body: Column(
          children: [
            _PropertyDetailTabBar(
              selectedIndex: controller.selectedTabIndex.value,
              onChanged: controller.selectTab,
            ),
            Expanded(
              child: switch (controller.selectedTabIndex.value) {
                0 => _OverviewTab(property: property),
                1 => const _TenantsTab(),
                2 => _InfoTab(property: property),
                _ => const _RecordsTab(),
              },
            ),
          ],
        ),
      );
    });
  }
}

class _PropertyDetailTabBar extends StatelessWidget {
  const _PropertyDetailTabBar({
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  static final _tabs = [
    (icon: Icons.grid_view_rounded, label: ConstString.overview),
    (icon: Icons.people_outline_rounded, label: ConstString.tenants),
    (icon: Icons.apartment_rounded, label: ConstString.info),
    (icon: Icons.folder_outlined, label: ConstString.records),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = index == selectedIndex;
          final tab = _tabs[index];
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? ConstColor.primaryColor
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
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
  const _OverviewTab({required this.property});

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PropertyDetailController>();
    return Obx(
      () => ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          _PropertyDetailHeaderCard(property: property, controller: controller),
          SizedBox(height: 16.h),
          CustomSegmentedToggle(
            options: [
              SegmentedOption(label: ConstString.all),
              SegmentedOption(label: ConstString.occupied),
              SegmentedOption(label: ConstString.vacant),
            ],
            selectedIndex: PropertiesFilter.values.indexOf(
              controller.unitFilter.value,
            ),
            onChanged: (i) =>
                controller.selectUnitFilter(PropertiesFilter.values[i]),
          ),
          SizedBox(height: 14.h),
          ...controller.filteredFloors.map(
            (floor) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: _FloorCard(floor: floor),
            ),
          ),
        ],
      ),
    );
  }
}

class _PropertyDetailHeaderCard extends StatelessWidget {
  const _PropertyDetailHeaderCard({
    required this.property,
    required this.controller,
  });

  final PropertyModel property;
  final PropertyDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ConstColor.dividerColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: property.photoUrls.isNotEmpty
                    ? AppImage(
                        path: property.photoUrls.first,
                        width: 66.r,
                        height: 66.r,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 66.r,
                        height: 66.r,
                        color: ConstColor.dividerColor,
                      ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _HeaderStat(
                      icon: Icons.layers_outlined,
                      value: '${controller.totalFloors}',
                      label: ConstString.floors,
                    ),
                    _HeaderStat(
                      icon: Icons.door_front_door_outlined,
                      value: '${controller.totalUnits}',
                      label: ConstString.units,
                    ),
                    _HeaderStat(
                      icon: Icons.people_outline_rounded,
                      value: '${controller.occupiedUnits}',
                      label: ConstString.occupied,
                    ),
                    _HeaderStat(
                      icon: Icons.door_back_door_outlined,
                      value: '${controller.vacantUnits}',
                      label: ConstString.vacant,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(color: ConstColor.dividerColor, height: 1),
          SizedBox(height: 10.h),
          Row(
            children: [
              CustomText(
                title: ConstString.totalRent,
                textSize: 11.sp,
                fontWeight: FontWeight.w600,
                textColor: ConstColor.bodyColor,
                letterSpacing: 0.4,
              ),
              const Spacer(),
              Icon(
                Icons.receipt_long_outlined,
                size: 14.sp,
                color: ConstColor.primaryColor,
              ),
              SizedBox(width: 4.w),
              CustomText(
                title: '£${controller.totalRent.toStringAsFixed(0)}/mo',
                textSize: 14.sp,
                fontWeight: FontWeight.w700,
                textColor: ConstColor.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderStat extends StatelessWidget {
  const _HeaderStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13.sp, color: ConstColor.titleColor),
            SizedBox(width: 3.w),
            CustomText(
              title: value,
              textSize: 13.sp,
              fontWeight: FontWeight.w700,
              textColor: ConstColor.titleColor,
            ),
          ],
        ),
        SizedBox(height: 2.h),
        CustomText(
          title: label,
          textSize: 10.sp,
          textColor: ConstColor.bodyColor,
        ),
      ],
    );
  }
}

class _FloorCard extends StatelessWidget {
  const _FloorCard({required this.floor});

  final FloorGroupModel floor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PropertyDetailController>();
    return Obx(() {
      final isExpanded = controller.expandedFloors.contains(floor.floorLabel);
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: ConstColor.dividerColor),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => controller.toggleFloorExpanded(floor.floorLabel),
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Row(
                  children: [
                    Icon(
                      Icons.layers_outlined,
                      size: 16.sp,
                      color: ConstColor.bodyColor,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomText(
                        title: floor.floorLabel,
                        textSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        textColor: ConstColor.titleColor,
                      ),
                    ),
                    CustomText(
                      title: '${floor.units.length} ${ConstString.units}',
                      textSize: 12.sp,
                      textColor: ConstColor.bodyColor,
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 18.sp,
                      color: ConstColor.bodyColor,
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded)
              ...floor.units.map(
                (u) => Padding(
                  padding: EdgeInsets.fromLTRB(12.r, 0, 12.r, 10.h),
                  child: _UnitRow(unit: u),
                ),
              ),
          ],
        ),
      );
    });
  }
}

class _UnitRow extends StatelessWidget {
  const _UnitRow({required this.unit});

  final UnitDetailModel unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: ConstColor.screenBackground,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: unit.photoUrl != null
                ? AppImage(
                    path: unit.photoUrl,
                    width: 40.r,
                    height: 40.r,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 40.r,
                    height: 40.r,
                    color: ConstColor.dividerColor,
                  ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: unit.label,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.titleColor,
                ),
                CustomText(
                  title: unit.bedBathLabel,
                  textSize: 11.sp,
                  textColor: ConstColor.bodyColor,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomStatusChip(
                label: unit.isOccupied
                    ? ConstString.occupied
                    : ConstString.vacant,
                color: unit.isOccupied
                    ? ConstColor.tenantIconColor
                    : ConstColor.contractorIconColor,
                backgroundColor: unit.isOccupied
                    ? ConstColor.tenantIconBg
                    : ConstColor.contractorIconBg,
              ),
              SizedBox(height: 3.h),
              CustomText(
                title: '£${unit.rent.toStringAsFixed(0)}/mo',
                textSize: 12.sp,
                fontWeight: FontWeight.w600,
                textColor: ConstColor.titleColor,
              ),
            ],
          ),
          Icon(
            Icons.chevron_right_rounded,
            size: 18.sp,
            color: ConstColor.bodyColor,
          ),
        ],
      ),
    );
  }
}

class _TenantsTab extends StatelessWidget {
  const _TenantsTab();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PropertyDetailController>();
    return Obx(
      () => ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          CustomText(
            title: '${controller.tenants.length} ${ConstString.activeLower}',
            textSize: 12.sp,
            fontWeight: FontWeight.w600,
            textColor: ConstColor.bodyColor,
          ),
          SizedBox(height: 10.h),
          ...controller.tenants.map(
            (t) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: _TenantListTile(
                data: t,
                onTap: () => controller.openTenantDetails(t),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TenantListTile extends StatelessWidget {
  const _TenantListTile({required this.data, required this.onTap});

  final PropertyTenantModel data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: ConstColor.bodyColor.withAlpha(50)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: AppImage(
                url: data.avatarUrl,
                width: 40.r,
                height: 40.r,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: data.name,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    textColor: ConstColor.titleColor,
                  ),
                  CustomText(
                    title:
                        '${data.unitLabel} · £${data.rent.toStringAsFixed(0)}/mo',
                    textSize: 12.sp,
                    textColor: ConstColor.bodyColor,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20.sp,
              color: ConstColor.bodyColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTab extends StatelessWidget {
  const _InfoTab({required this.property});

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PropertyDetailController>();
    return Obx(() {
      final p = controller.property.value ?? property;
      return ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _HeaderStat(
                    icon: Icons.people_outline_rounded,
                    value: '${controller.occupiedUnits}',
                    label: ConstString.occupied,
                  ),
                ),
                Expanded(
                  child: _HeaderStat(
                    icon: Icons.door_back_door_outlined,
                    value: '${controller.vacantUnits}',
                    label: ConstString.vacant,
                  ),
                ),
                Expanded(
                  child: _HeaderStat(
                    icon: Icons.door_front_door_outlined,
                    value: '${controller.totalUnits}',
                    label: ConstString.units,
                  ),
                ),
                Expanded(
                  child: _HeaderStat(
                    icon: Icons.layers_outlined,
                    value: '${controller.totalFloors}',
                    label: ConstString.floors,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: ConstString.propertyPhotos,
                textSize: 14.sp,
                fontWeight: FontWeight.w700,
                textColor: ConstColor.titleColor,
              ),
              GestureDetector(
                onTap: controller.openPropertyPhotos,
                child: CustomText(
                  title: ConstString.viewAllLabel,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  textColor: ConstColor.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          SizedBox(
            height: 70.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: p.photoUrls.length,
              separatorBuilder: (_, index) => SizedBox(width: 8.w),
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: AppImage(
                  path: p.photoUrls[index],
                  width: 70.w,
                  height: 70.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          CustomText(
            title: ConstString.propertyInformation,
            textSize: 14.sp,
            fontWeight: FontWeight.w700,
            textColor: ConstColor.titleColor,
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                DetailRow(
                  icon: Icons.location_on_outlined,
                  label: ConstString.address,
                  value: p.address ?? '-',
                ),
                DetailRow(
                  icon: Icons.markunread_mailbox_outlined,
                  label: ConstString.postcode,
                  value: p.postcode ?? '-',
                ),
                DetailRow(
                  icon: Icons.home_work_outlined,
                  label: ConstString.type,
                  value: p.propertyType?.label ?? '-',
                ),
                DetailRow(
                  icon: Icons.calendar_today_outlined,
                  label: ConstString.yearBuilt,
                  value: p.yearBuilt ?? '-',
                ),
                DetailRow(
                  icon: Icons.event_outlined,
                  label: ConstString.datePurchased,
                  value: p.datePurchased != null
                      ? PropertiesController.formatDate(p.datePurchased!)
                      : '-',
                ),
                DetailRow(
                  icon: Icons.trending_up_rounded,
                  label: ConstString.valuation,
                  value: p.valuation != null
                      ? '£${p.valuation!.toStringAsFixed(0)}'
                      : '-',
                ),
                DetailRow(
                  icon: Icons.calendar_month_outlined,
                  label: ConstString.valuationDate,
                  value: p.valuationDate != null
                      ? PropertiesController.formatDate(p.valuationDate!)
                      : '-',
                ),
                DetailRow(
                  icon: Icons.straighten_outlined,
                  label: ConstString.totalSizeSqft,
                  value: p.totalSizeSqft ?? '-',
                ),
                DetailRow(
                  icon: Icons.bolt_outlined,
                  label: ConstString.epcRatingLabel,
                  value: p.epcRating != null
                      ? 'Rating ${p.epcRating!.label}'
                      : '-',
                ),
                DetailRow(
                  icon: Icons.event_available_outlined,
                  label: ConstString.epcExpiry,
                  value: p.epcExpiry != null
                      ? PropertiesController.formatDate(p.epcExpiry!)
                      : '-',
                ),
                DetailRow(
                  icon: Icons.verified_user_outlined,
                  label: ConstString.insuranceRenewal,
                  value: p.insuranceRenewal != null
                      ? PropertiesController.formatDate(p.insuranceRenewal!)
                      : '-',
                ),
                DetailRow(
                  icon: Icons.account_balance_outlined,
                  label: ConstString.councilTax,
                  value: p.councilTaxBand?.label ?? '-',
                  isLast: true,
                ),
              ],
            ),
          ),
          if (p.notes != null) ...[
            SizedBox(height: 16.h),
            CustomText(
              title: ConstString.notesUpper,
              textSize: 11.sp,
              fontWeight: FontWeight.w600,
              textColor: ConstColor.bodyColor,
              letterSpacing: 0.5,
            ),
            SizedBox(height: 6.h),
            CustomText(
              title: p.notes!,
              textSize: 13.sp,
              textColor: ConstColor.titleColor,
              textHeight: 1.4,
              maxLine: 10,
            ),
          ],
          SizedBox(height: 16.h),
          NavListTile(
            icon: Icons.dashboard_outlined,
            iconColor: ConstColor.tenantIconColor,
            iconBg: ConstColor.tenantIconBg,
            title: ConstString.floorPlansAndLayouts,
            subtitle:
                '${p.floorPlanUrls.length} ${ConstString.layoutsUploadedSuffix}',
            onTap: controller.openFloorPlans,
          ),
          SizedBox(height: 8.h),
          NavListTile(
            icon: Icons.bolt_outlined,
            iconColor: ConstColor.primaryColor,
            iconBg: ConstColor.infoBg,
            title: ConstString.buildingCommunalServices,
            subtitle: 'Main Stopcock, Bin collection, Common power & bays',
            onTap: controller.openServicesMeters,
          ),
        ],
      );
    });
  }
}

class _RecordsTab extends StatelessWidget {
  const _RecordsTab();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecordsController(), tag: 'records');
    final categories = [
      RecordCategoryModel(
        id: 'compliance',
        icon: Icons.shield_outlined,
        iconColor: ConstColor.primaryColor,
        iconBg: ConstColor.infoBg,
        title: ConstString.compliance,
        subtitle: ConstString.complianceSubtitle,
      ),
      RecordCategoryModel(
        id: 'safety',
        icon: Icons.notifications_active_outlined,
        iconColor: ConstColor.contractorIconColor,
        iconBg: ConstColor.contractorIconBg,
        title: ConstString.safetyAlarms,
        subtitle: ConstString.safetyAlarmsSubtitle,
      ),
      RecordCategoryModel(
        id: 'appliances',
        icon: Icons.local_fire_department_outlined,
        iconColor: ConstColor.errorColor,
        iconBg: ConstColor.errorBg,
        title: ConstString.appliances,
        subtitle: ConstString.appliancesSubtitle,
      ),
      RecordCategoryModel(
        id: 'utilities',
        icon: Icons.bolt_outlined,
        iconColor: ConstColor.primaryColor,
        iconBg: ConstColor.infoBg,
        title: ConstString.utilitiesMeters,
        subtitle: ConstString.utilitiesMetersSubtitle,
      ),
      RecordCategoryModel(
        id: 'inspections',
        icon: Icons.fact_check_outlined,
        iconColor: ConstColor.tenantIconColor,
        iconBg: ConstColor.tenantIconBg,
        title: ConstString.inspections,
        subtitle: ConstString.inspectionsSubtitle,
      ),
      RecordCategoryModel(
        id: 'inventories',
        icon: Icons.inventory_2_outlined,
        iconColor: ConstColor.purpleColor,
        iconBg: ConstColor.purpleBg,
        title: ConstString.inventories,
        subtitle: ConstString.inventoriesSubtitle,
      ),
      RecordCategoryModel(
        id: 'house_rules',
        icon: Icons.menu_book_outlined,
        iconColor: ConstColor.primaryColor,
        iconBg: ConstColor.infoBg,
        title: ConstString.houseRules,
        subtitle: ConstString.houseRulesSubtitle,
      ),
      RecordCategoryModel(
        id: 'vault',
        icon: Icons.folder_shared_outlined,
        iconColor: ConstColor.contractorIconColor,
        iconBg: ConstColor.contractorIconBg,
        title: ConstString.documentVault,
        subtitle: ConstString.documentVaultSubtitle,
      ),
    ];

    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 1.45,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final c = categories[index];
        return GestureDetector(
          onTap: () {
            switch (c.id) {
              case 'compliance':
                controller.openComplianceHub();
                break;
              case 'safety':
                Get.toNamed(AppRoutes.safetyAlarmsScreen);
                break;
              case 'appliances':
                Get.toNamed(AppRoutes.appliancesScreen);
                break;
              case 'utilities':
                Get.toNamed(AppRoutes.utilitiesMetersScreen);
                break;
              case 'inspections':
                Get.toNamed(AppRoutes.inspectionsScreen);
                break;
              case 'house_rules':
                Get.toNamed(AppRoutes.houseRulesScreen);
                break;
              case 'inventories':
              case 'vault':
                controller.notifyComingSoon(c.title);
                break;
            }
          },
          child: Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: ConstColor.titleColor.withAlpha(30))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconBadge(
                      icon: c.icon,
                      iconColor: c.iconColor,
                      backgroundColor: c.iconBg,
                      size: 36,
                      isCircle: false,
                      borderRadius: 10,
                        border: Border.all(color: ConstColor.titleColor.withAlpha(30))
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 18.sp,
                      color: ConstColor.bodyColor,
                    ),
                  ],
                ),
                const Spacer(),
                CustomText(
                  title: c.title,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  textColor: ConstColor.titleColor,
                  maxLine: 1,
                ),
                CustomText(
                  title: c.subtitle,
                  textSize: 10.sp,
                  textColor: ConstColor.bodyColor,
                  maxLine: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
