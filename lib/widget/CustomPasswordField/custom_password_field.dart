import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/const_color.dart';
import '../CustomTextFormField/custom_text_form_field.dart';

/// Reused across Sign In / Create New Password / Sign Up screens.
/// Wraps CustomTextFormField with an obscure/eye-toggle icon.
class CustomPasswordField extends StatefulWidget {
  final String fromTitle;
  final Widget? hintText;
  final TextEditingController? textController;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;

  const CustomPasswordField({
    super.key,
    this.fromTitle = "",
    this.hintText,
    this.textController,
    this.validator,
    this.textInputAction,
    this.onChanged,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      fromTitle: widget.fromTitle,
      hintText: widget.hintText,
      textController: widget.textController,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      obscureText: _obscure,
      suffixIcon: IconButton(
        icon: Icon(
          _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          size: 20.sp,
          color: ConstColor.bodyColor,
        ),
        onPressed: () => setState(() => _obscure = !_obscure),
      ),
    );
  }
}