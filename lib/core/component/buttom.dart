import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/core/utilities/colors.dart';

class CustomButtom extends StatelessWidget {
  final String text;
  final VoidCallback function;

  const CustomButtom({required this.text, required this.function, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ElevatedButton(
        onPressed: function,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.mainColor)),
        child: Text(
          text,
          style: TextStyle(color: AppColors.whiteColor, fontFamily: 'Tajawal'),
        ),
      ),
    );
  }
}
