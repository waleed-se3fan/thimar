import 'package:flutter/material.dart';
import 'package:salla_thumara/core/utilities/colors.dart';

class CustomMainText extends StatelessWidget {
  final String? text;
  final TextAlign? align;
  final double? fontSize;

  const CustomMainText(
      {super.key, required this.text, this.align, required this.fontSize});
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: align,
      style: TextStyle(
          fontSize: fontSize,
          color: AppColors.mainColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Tajawal'),
    );
  }
}
