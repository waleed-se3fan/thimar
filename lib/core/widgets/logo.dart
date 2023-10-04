import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salla_thumara/core/utilities/images.dart';

myLogo() {
  return Align(
    alignment: Alignment.center,
    child: SvgPicture.asset(
      AppImaes().logo,
      width: 129.83.w,
      height: 125.72.h,
    ),
  );
}
