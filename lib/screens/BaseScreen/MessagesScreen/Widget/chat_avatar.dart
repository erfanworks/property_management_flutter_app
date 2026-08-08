import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AppImage/app_image.dart';

/// Reused in conversation list, chat header, and new-message picker.
class ChatAvatar extends StatelessWidget {
  final String? imageUrl;
  final bool isOnline;
  final bool isGroup;
  final double size;

  const ChatAvatar({
    super.key,
    this.imageUrl,
    this.isOnline = false,
    this.isGroup = false,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipOval(
          child: isGroup
              ? Container(
            width: size.w,
            height: size.w,
            color: ConstColor.primaryColor.withAlpha(25),
            child: Icon(Icons.groups_rounded, color: ConstColor.primaryColor, size: (size * 0.5).sp),
          )
              : AppImage(url: imageUrl, width: size.w, height: size.w, fit: BoxFit.cover),
        ),
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}