// lib/screens/UserScreen/HomeScreen/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_icons.dart';
import '../../../../constant/const_string.dart';
import '../../../../routes/app_routes/app_routes.dart';
import 'widget/brand_header.dart';
import '../../../../widget/CustomIconBadge/custom_icon_badge.dart';
import 'widget/custom_section_header.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import 'controller/home_controller.dart';
import 'model/home_dashboard_model.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      appBar: GlobalAppBar(
        showBack: false,
        leading: IconButton(
          icon: Icon(
            Icons.menu_rounded,
            color: ConstColor.titleColor,
            size: 24.sp,
          ),
          onPressed: () {}, // TODO: open drawer
        ),
        centerWidget: BrandHeader(
          title: ConstString.splashTitle,
          tagline: ConstString.homeAppTagline,
        ),
        actions: [
          AppBarBell(
            onTap: () => Get.toNamed(AppRoutes.notificationScreen),
            badgeCount: 0,
          ),
        ],
      ),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
          children: [
            _IncomeOverviewCard(data: controller.incomeOverview.value),
            SizedBox(height: 16.h),
            _FinancialOverviewCard(data: controller.financialOverview.value),
            SizedBox(height: 16.h),
            const _QuickActionsRow(),
            SizedBox(height: 20.h),
            CustomSectionHeader(title: ConstString.needsAttention),
            SizedBox(height: 10.h),
            ...controller.attentionItems.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: _AttentionTile(data: item),
              ),
            ),
            SizedBox(height: 10.h),
            CustomSectionHeader(
              title: ConstString.smartReminders,
              actionLabel: ConstString.viewAll,
              onActionTap: () {},
            ),
            SizedBox(height: 10.h),
            ...controller.reminders.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: _ReminderTile(data: item),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IncomeOverviewCard extends StatelessWidget {
  const _IncomeOverviewCard({required this.data});

  final IncomeOverviewModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ConstColor.primaryColor, ConstColor.cardGradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -45.r,
            right: -30.r,
            child: Container(
              width: 110.r,
              height: 110.r,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(20),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 18.w,
            bottom: 67.h,
            child: Image.asset(
              'assets/images/home_screen_property.png',
              height: 70.h,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: ConstString.monthlyIncome,
                  textSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  textColor: Colors.white.withAlpha(200),
                  letterSpacing: 0.6,
                ),
                SizedBox(height: 6.h),
                CustomText(
                  title:
                      '£${data.monthlyIncome.toStringAsFixed(0).replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]},")}',
                  textSize: 30.sp,
                  fontWeight: FontWeight.w800,
                  textColor: Colors.white,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  title:
                      'From ${data.occupiedPropertiesCount} ${ConstString.occupiedPropertiesSuffix}',
                  textSize: 12.sp,
                  textColor: Colors.white.withAlpha(200),
                ),
                SizedBox(height: 14.h),
                Divider(color: Colors.white.withAlpha(40), thickness: 1),
                // SizedBox(height: 10.h),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      _StatColumn(
                        value: '${data.totalProperties}',
                        label: ConstString.properties,
                      ),
                      VerticalDivider(
                        color: Colors.white.withAlpha(40),
                        thickness: 1.w,
                        indent: 4.h,
                        endIndent: 4.h,
                      ),
                      _StatColumn(
                        value: '${data.totalTenants}',
                        label: ConstString.tenants,
                      ),
                      VerticalDivider(
                        color: Colors.white.withAlpha(40),
                        thickness: 1.w,
                        indent: 4.h,
                        endIndent: 4.h,
                      ),
                      _StatColumn(
                        value: '${data.occupiedPercentage}%',
                        label: ConstString.occupied,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CustomText(
            title: value,
            textSize: 16.sp,
            fontWeight: FontWeight.w700,
            textColor: Colors.white,
          ),
          SizedBox(height: 3.h),
          CustomText(
            title: label,
            textSize: 11.sp,
            textColor: Colors.white.withAlpha(200),
          ),
        ],
      ),
    );
  }
}

class _FinancialOverviewCard extends StatelessWidget {
  const _FinancialOverviewCard({required this.data});

  final FinancialOverviewModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ConstColor.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: ConstString.financialOverview,
            textSize: 15.sp,
            fontWeight: FontWeight.w700,
            textColor: ConstColor.titleColor,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              SizedBox(
                width: 84.r,
                height: 84.r,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 84.r,
                      height: 84.r,
                      child: CircularProgressIndicator(
                        value: data.collectedPercentage / 100,
                        strokeWidth: 6.r,
                        backgroundColor: ConstColor.dividerColor,
                        valueColor: AlwaysStoppedAnimation(
                          ConstColor.tenantIconColor,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          title: '${data.collectedPercentage}%',
                          textSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          textColor: ConstColor.titleColor,
                        ),
                        CustomText(
                          title: ConstString.collected,
                          textSize: 10.sp,
                          textColor: ConstColor.bodyColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  children: [
                    _LegendRow(
                      color: ConstColor.tenantIconColor,
                      label: ConstString.paid,
                      amount: data.paidAmount,
                    ),
                    SizedBox(height: 8.h),
                    _LegendRow(
                      color: ConstColor.contractorIconColor,
                      label: ConstString.pending,
                      amount: data.pendingAmount,
                    ),
                    SizedBox(height: 8.h),
                    _LegendRow(
                      color: ConstColor.errorColor,
                      label: ConstString.overdue,
                      amount: data.overdueAmount,
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

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    required this.color,
    required this.label,
    required this.amount,
  });

  final Color color;
  final String label;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8.r,
          height: 8.r,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: CustomText(
            title: label,
            textSize: 13.sp,
            textColor: ConstColor.titleColor,
          ),
        ),
        CustomText(
          title: '£${amount.toStringAsFixed(0)}',
          textSize: 13.sp,
          fontWeight: FontWeight.w600,
          textColor: ConstColor.titleColor,
        ),
      ],
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _QuickActionItem(
                svgPath: ConstIcons.announcementIcon,
                iconColor: ConstColor.purpleColor,
                iconBg: ConstColor.purpleBg,
                label: ConstString.announcement,
                onTap: () => Get.toNamed(AppRoutes.announcementListScreen),
              ),
            ),
            VerticalDivider(
              color: ConstColor.dividerColor,
              thickness: 1.w,
              indent: 2.h,
              endIndent: 2.h,
            ),
            Expanded(
              child: _QuickActionItem(
                svgPath: ConstIcons.issuesTabIcon,
                iconColor: ConstColor.contractorIconColor,
                iconBg: ConstColor.contractorIconBg,
                label: ConstString.maintenance,
                onTap: () => Get.toNamed(AppRoutes.maintenanceListScreen),
              ),
            ),
            VerticalDivider(
              color: ConstColor.dividerColor,
              thickness: 1.w,
              indent: 2.h,
              endIndent: 2.h,
            ),
            Expanded(
              child: _QuickActionItem(
                svgPath: ConstIcons.financeIcon,
                iconColor: ConstColor.primaryColor,
                iconBg: ConstColor.infoBg,
                label: ConstString.finance,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  const _QuickActionItem({
    required this.svgPath,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.onTap,
  });

  final String svgPath;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CustomIconBadge(
            svgPath: svgPath,
            iconColor: iconColor,
            backgroundColor: iconBg,
            size: 52,
            isCircle: false,
            borderRadius: 14,
          ),
          SizedBox(height: 6.h),
          CustomText(
            title: label,
            textSize: 12.sp,
            fontWeight: FontWeight.w500,
            textColor: ConstColor.titleColor,
          ),
        ],
      ),
    );
  }
}

class _AttentionTile extends StatelessWidget {
  const _AttentionTile({required this.data});

  final AttentionItemModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          CustomIconBadge(
            icon: data.icon,
            iconColor: data.iconColor,
            backgroundColor: data.iconBg,
            size: 42,
            isCircle: false,
            borderRadius: 12,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: data.title,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.titleColor,
                  maxLine: 1,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  title: data.subtitle,
                  textSize: 12.sp,
                  textColor: ConstColor.bodyColor,
                  maxLine: 1,
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: ConstColor.bodyColor,
            size: 20.sp,
          ),
        ],
      ),
    );
  }
}

class _ReminderTile extends StatelessWidget {
  const _ReminderTile({required this.data});

  final ReminderItemModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border(
          left: BorderSide(color: data.iconColor, width: 3.w),
        ),
      ),
      child: Row(
        children: [
          CustomIconBadge(
            icon: data.icon,
            iconColor: data.iconColor,
            backgroundColor: data.iconBg,
            size: 40,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: data.title,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.titleColor,
                  maxLine: 1,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  title: data.subtitle,
                  textSize: 12.sp,
                  textColor: ConstColor.bodyColor,
                  maxLine: 1,
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: ConstColor.bodyColor,
            size: 20.sp,
          ),
        ],
      ),
    );
  }
}
