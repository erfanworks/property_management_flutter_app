import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/const_color.dart';
import '../text/custom_text.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? action;

  const GlobalAppBar({
    super.key,
    this.title,
    this.showBack = true,
    this.onBack,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ConstColor.primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            if (showBack) ...[
              GestureDetector(
                onTap: onBack ?? () => Navigator.pop(context),
                child: Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    size: 18.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              if (title != null) SizedBox(width: 10.w),
            ],
            if (title != null)
              Expanded(
                child: CustomText(
                  title: title!,
                  textColor: Colors.white,
                  textSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
              )
            else
              const Spacer(),
            ?action,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
