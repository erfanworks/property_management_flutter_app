import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../constant/const_color.dart';

class NavBarBottom extends StatelessWidget {
  final Function(int) onTap;
  final List<String> icons;
  final List<String> labels;
  final int selectedIndex;

  const NavBarBottom({
    super.key,
    required this.onTap,
    required this.icons,
    required this.labels,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 12.r,
            offset: Offset(0, -3.h),
          ),
        ],
      ),
      child: Row(
        children: List.generate(icons.length, (index) {
          final bool isSelected = selectedIndex == index;

          return Expanded(
            child: InkWell(
              onTap: () => onTap(index),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      icons[index],
                      width: 24.w,
                      height: 24.h,
                      colorFilter: ColorFilter.mode(
                        isSelected ? ConstColor.primaryColor : ConstColor.bodyColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      labels.length > index ? labels[index] : '',
                      style: TextStyle(
                        color: isSelected ? ConstColor.primaryColor : ConstColor.bodyColor,
                        fontSize: 12.sp,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        fontFamily: 'Poppins',
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