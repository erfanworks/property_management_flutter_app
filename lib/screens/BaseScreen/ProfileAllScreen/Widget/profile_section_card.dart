import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/text/custom_text.dart';


class ProfileMenuItemModel {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const ProfileMenuItemModel({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  });
}

class ProfileSectionModel {
  final String? header;
  final String? subtitle;
  final List<ProfileMenuItemModel> items;

  const ProfileSectionModel({this.header, this.subtitle, required this.items});
}

/// Reused for every section block across all 3 role Profile screens.
class ProfileSectionCard extends StatelessWidget {
  final ProfileSectionModel section;

  const ProfileSectionCard({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section.header != null) ...[
            CustomText(
              title: section.header!,
              textSize: 12.sp,
              fontWeight: FontWeight.w700,
              textColor: ConstColor.bodyColor,
            ),
            if (section.subtitle != null) ...[
              SizedBox(height: 2.h),
              CustomText(title: section.subtitle!, textSize: 11.sp, textColor: ConstColor.bodyColor),
            ],
            SizedBox(height: 8.h),
          ],
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Column(
              children: List.generate(section.items.length, (index) {
                final item = section.items[index];
                return Column(
                  children: [
                    _ProfileMenuTile(item: item),
                    if (index != section.items.length - 1)
                      Divider(
                        height: 1,
                        indent: 16.w,
                        endIndent: 16.w,
                        color: ConstColor.bodyColor.withAlpha(40),
                      ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuTile extends StatelessWidget {
  final ProfileMenuItemModel item;

  const _ProfileMenuTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Row(
          children: [
            Icon(item.icon, size: 20.sp, color: ConstColor.titleColor),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: item.title,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    textColor: ConstColor.titleColor,
                  ),
                  if (item.subtitle != null) ...[
                    SizedBox(height: 2.h),
                    CustomText(title: item.subtitle!, textSize: 12.sp, textColor: ConstColor.bodyColor),
                  ],
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, size: 20.sp, color: ConstColor.bodyColor),
          ],
        ),
      ),
    );
  }
}