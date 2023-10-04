import 'package:flutter/material.dart';
import 'package:salla_thumara/core/utilities/colors.dart';

class CustomSubmainText extends StatelessWidget {
  final String? text;
  final TextAlign? align;

  const CustomSubmainText({super.key, this.text, this.align});
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: align,
      style: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 16,
          color: AppColors.grayColor,
          fontWeight: FontWeight.normal),
    );
  }
}
