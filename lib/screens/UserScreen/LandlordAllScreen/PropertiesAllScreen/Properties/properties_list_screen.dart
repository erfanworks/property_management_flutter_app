// lib/screens/UserScreen/LandlordAllScreen/Properties/properties_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../models/property_model.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomStatusChip/custom_status_chip.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/text/custom_text.dart';
import 'controller/properties_controller.dart';
import 'model/properties_filter.dart';

class PropertiesListScreen extends GetView<PropertiesController> {
  const PropertiesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        title: ConstString.properties,
        showBack: false,
        actions: [AppBarTextAction(label: ConstString.addProperty, icon: Icons.add_rounded, onTap: controller.openAddProperty)],
      ),
      body: Obx(
            () => ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: ConstColor.dividerColor),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _PortfolioStat(
                      icon: Icons.apartment_rounded,
                      iconColor: ConstColor.primaryColor,
                      iconBg: ConstColor.infoBg,
                      value: '${controller.totalPropertiesCount}',
                      label: ConstString.totalProperties,
                    ),
                  ),
                  Expanded(
                    child: _PortfolioStat(
                      icon: Icons.home_work_outlined,
                      iconColor: ConstColor.tenantIconColor,
                      iconBg: ConstColor.tenantIconBg,
                      value: '${controller.totalUnitsCount}',
                      label: ConstString.totalUnits,
                    ),
                  ),
                  Expanded(
                    child: _PortfolioStat(
                      icon: Icons.pie_chart_outline_rounded,
                      iconColor: ConstColor.purpleColor,
                      iconBg: ConstColor.purpleBg,
                      value: '${controller.overallOccupancyPercentage}%',
                      label: ConstString.overallOccupancy,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            _PropertyFilterTabs(
              selectedFilter: controller.selectedFilter.value,
              allCount: controller.totalPropertiesCount,
              occupiedCount: controller.occupiedPropertiesCount,
              vacantCount: controller.vacantPropertiesCount,
              onChanged: controller.selectFilter,
            ),
            SizedBox(height: 14.h),
            ...controller.filteredProperties.map(
                  (p) => Padding(padding: EdgeInsets.only(bottom: 12.h), child: _PropertyCard(data: p)),
            ),
          ],
        ),
      ),
    );
  }
}

class _PortfolioStat extends StatelessWidget {
  const _PortfolioStat({required this.icon, required this.iconColor, required this.iconBg, required this.value, required this.label});
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: iconColor, size: 18.sp),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                title: value,
                textSize: 15.sp,
                fontWeight: FontWeight.w700,
                textColor: ConstColor.titleColor,
              ),
              CustomText(
                title: label,
                textSize: 10.sp,
                textColor: ConstColor.bodyColor,
                maxLine: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PropertyFilterTabs extends StatelessWidget {
  const _PropertyFilterTabs({required this.selectedFilter, required this.allCount, required this.occupiedCount, required this.vacantCount, required this.onChanged});
  final PropertiesFilter selectedFilter;
  final int allCount;
  final int occupiedCount;
  final int vacantCount;
  final ValueChanged<PropertiesFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      (filter: PropertiesFilter.all, count: allCount, icon: Icons.apartment_rounded),
      (filter: PropertiesFilter.occupied, count: occupiedCount, icon: Icons.people_outline_rounded),
      (filter: PropertiesFilter.vacant, count: vacantCount, icon: Icons.home_outlined),
    ];
    return Row(
      children: tabs.map((tab) {
        final isSelected = tab.filter == selectedFilter;
        return Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: GestureDetector(
            onTap: () => onChanged(tab.filter),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: isSelected ? ConstColor.primaryColor : ConstColor.dividerColor.withAlpha(40),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: isSelected ? ConstColor.primaryColor : ConstColor.dividerColor),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    tab.icon,
                    size: 14.sp,
                    color: isSelected ? Colors.white : ConstColor.titleColor,
                  ),
                  SizedBox(width: 4.w),
                  CustomText(
                    title: '${tab.filter.label} (${tab.count})',
                    textSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    textColor: isSelected ? Colors.white : ConstColor.titleColor,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  const _PropertyCard({required this.data});
  final PropertyModel data;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PropertiesController>();
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ConstColor.dividerColor),
      ),
      child: GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.propertyDetailScreen, arguments: data),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: data.photoUrls.isNotEmpty
                    ? AppImage(path: data.photoUrls.first, width: 56.r, height: 56.r, fit: BoxFit.cover)
                    : Container(width: 80.r, height: 86.r, color: ConstColor.dividerColor, child: Icon(Icons.apartment_rounded, color: ConstColor.bodyColor)),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(title: data.name, textSize: 14.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor, maxLine: 1),
                    CustomText(title: data.address ?? '', textSize: 12.sp, textColor: ConstColor.bodyColor, maxLine: 1),
                    SizedBox(height: 4.h),
                    data.isFullyVacant
                        ? CustomStatusChip(label: ConstString.vacant, color: ConstColor.contractorIconColor, backgroundColor: ConstColor.contractorIconBg)
                        : CustomStatusChip(label: '${data.occupiedUnitsCount}/${data.totalUnitsCount} occupied', color: ConstColor.primaryColor, backgroundColor: ConstColor.infoBg),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                color: Colors.white,
                icon: Icon(Icons.more_vert_rounded, color: ConstColor.bodyColor),
                onSelected: (value) {
                  if (value == 'edit') controller.openEditProperty(data);
                  if (value == 'delete') controller.confirmDeleteProperty(data);
                  // 'add_unit' — feature-e porer dey dibo
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit_outlined, size: 18.sp, color: ConstColor.titleColor), SizedBox(width: 8.w), CustomText(title: ConstString.editPropertyAction, textSize: 13.sp)])),
                  PopupMenuItem(value: 'add_unit', child: Row(children: [Icon(Icons.add_rounded, size: 18.sp, color: ConstColor.titleColor), SizedBox(width: 8.w), CustomText(title: ConstString.addUnit, textSize: 13.sp)])),
                  PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete_outline_rounded, size: 18.sp, color: ConstColor.errorColor), SizedBox(width: 8.w), CustomText(title: ConstString.deleteProperty, textSize: 13.sp, textColor: ConstColor.errorColor)])),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Divider(color: ConstColor.dividerColor, height: 1),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(child: _PropertyStatColumn(icon: Icons.payments_outlined, label: ConstString.monthlyRentLabel, value: '£${(data.monthlyRent ?? 0).toStringAsFixed(0)}')),
              Expanded(child: _PropertyStatColumn(icon: Icons.door_front_door_outlined, label: ConstString.totalUnitsShort, value: '${data.totalUnitsCount}')),
              Expanded(child: _PropertyStatColumn(icon: Icons.trending_up_rounded, label: ConstString.occupancyRate, value: '${data.occupancyPercentage}%')),
            ],
          ),
        ],
      ),
    ));
  }
}

class _PropertyStatColumn extends StatelessWidget {
  const _PropertyStatColumn({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Icon(icon, size: 12.sp, color: ConstColor.bodyColor), SizedBox(width: 4.w), CustomText(title: label, textSize: 10.sp, textColor: ConstColor.bodyColor)]),
        SizedBox(height: 2.h),
        CustomText(title: value, textSize: 13.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
      ],
    );
  }
}