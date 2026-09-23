// lib/screens/UserScreen/LandlordAllScreen/Finance/payment_success_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../routes/app_routes/app_routes.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/text/custom_text.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.screenBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline_rounded, size: 64.sp, color: ConstColor.bodyColor),
              SizedBox(height: 16.h),
              CustomText(title: ConstString.allCaughtUp, textSize: 18.sp, fontWeight: FontWeight.w700, textColor: ConstColor.titleColor),
              SizedBox(height: 6.h),
              CustomText(title: ConstString.allCaughtUpSubtitle, textSize: 13.sp, textColor: ConstColor.bodyColor, textAlign: TextAlign.center),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () => Get.until((route) => route.settings.name == AppRoutes.navBar),
                      isOutLined: true,
                      elevation: 0,
                      outLineColour: ConstColor.dividerColor,
                      child: CustomText(title: ConstString.backToHome, textColor: ConstColor.titleColor, textSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () {}, // TODO: navigate to the newly-created receipt once backend returns its id
                      child: CustomText(title: ConstString.viewReceipt, textColor: Colors.white, textSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}