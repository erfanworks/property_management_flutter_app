import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String title;
  final Color textColor;
  final FontWeight? fontWeight;
  final double textSize;
  final String? fontFamily;
  final double top;
  final double right;
  final double left;
  final double bottom;
  final TextAlign textAlign;
  final int maxLine;
  final double? textHeight;
  final double? letterSpacing;
  final TextOverflow? overflow;
  final TextDecoration? decorationStyle;
  final FontStyle? fontStyle;

  const CustomText({
    super.key,
    required this.title,
    this.textColor = const Color(0xFF363636),
    this.fontWeight,
    this.textSize = 14,
    this.fontFamily,
    this.top = 0,
    this.right = 0,
    this.left = 0,
    this.bottom = 0,
    this.textAlign = TextAlign.left,
    this.maxLine = 2,
    this.textHeight,
    this.letterSpacing,
    this.overflow,
    this.decorationStyle,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        left: left,
        right: right,
        bottom: bottom,
      ),
      child: Text(
        title,
        textAlign: textAlign,
        maxLines: maxLine,
        overflow: overflow ?? TextOverflow.ellipsis,
        style: TextStyle(
          height: textHeight,
          fontFamily: fontFamily ?? GoogleFonts.inter().fontFamily,
          fontSize: textSize,
          fontWeight: fontWeight,
          color: textColor,
          letterSpacing: letterSpacing,
          decorationColor: textColor,
          fontStyle: fontStyle ?? FontStyle.normal,
          decoration: decorationStyle ?? TextDecoration.none

        ),
      ),
    );
  }
}