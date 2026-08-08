import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constant/const_string.dart';
import '../../../widget/AppImage/app_image.dart';
import '../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../widget/text/custom_text.dart';
import '../AuthScreen/Widget/auth_header_widget.dart';
import 'Controller/role_select_screen_controller.dart';
import 'Widget/role_selection_card.dart';

class RoleSelectScreen extends StatelessWidget {
  const RoleSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoleSelectScreenController>(
      init: RoleSelectScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40.h),
                  AuthHeaderWidget(
                    icon: AppImage(
                      path: "assets/images/app_logo.png", // TODO: add asset
                      width: 28.w,
                      height: 28.w,
                      fit: BoxFit.contain,
                    ),
                    title: ConstString.roleSelectTitle,
                    subtitle: ConstString.roleSelectSubtitle,
                  ),
                  SizedBox(height: 28.h),
                  Obx(
                        () => Column(
                      children: controller.roles.map((role) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
                          child: RoleSelectionCard(
                            icon: role.icon,
                            iconBgColor: role.iconBgColor,
                            iconColor: role.iconColor,
                            title: role.title,
                            subtitle: role.subtitle,
                            isSelected: controller.selectedRole.value == role.type,
                            onTap: () => controller.onSelectRole(role.type),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Obx(
                        () => CustomElevatedButton(
                      onPressed: controller.onContinue,
                      child: CustomText(
                        title: "${ConstString.enterAs} ${controller.selectedRoleLabel}",
                        textColor: Colors.white,
                        textSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}