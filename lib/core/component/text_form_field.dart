// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/images.dart';

// ignore: must_be_immutable
class CustomTextFeild extends StatefulWidget {
  final String? hint_text;
  final String? label_text;
  final String? suffix_icon;
  final String? preffic_icon;
  final double? width;
  late final bool isPhoneNumber;
  late final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? myController;
  final TextInputType? inputType;
  bool? isLastLabel = true;
  CustomTextFeild(
      {super.key,
      this.label_text,
      this.validator,
      required this.isPassword,
      this.inputType,
      this.preffic_icon,
      required this.isPhoneNumber,
      this.hint_text,
      this.suffix_icon,
      this.isLastLabel,
      this.width,
      this.myController});
  bool obsecure = true;

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildWithPerfixState();
}

class _CustomTextFeildWithPerfixState extends State<CustomTextFeild> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.inputType,
      cursorColor: AppColors.mainColor,
      textInputAction: widget.isLastLabel == true
          ? TextInputAction.done
          : TextInputAction.next,
      cursorHeight: 18.h,
      controller: widget.myController,
      validator: widget.validator,
      obscureText: widget.obsecure && widget.isPassword ? true : false,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          isDense: true,
          icon: widget.isPhoneNumber
              ? Container(
                  padding:  EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        width: 1.w,
                        color: AppColors.submainColor,
                      )),
                  child: Image.asset(AppImaes().saudyaarab, height: 30.h),
                )
              : null,
          constraints: BoxConstraints(maxHeight: 68.h),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.mainColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.mainColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.mainColor)),
          labelText: '  ${widget.label_text}',
          labelStyle: const TextStyle(fontSize: 15, fontFamily: 'Tajawal'),
          suffixIcon: widget.isPassword == true
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.obsecure = !widget.obsecure;
                    });
                  },
                  child: widget.obsecure
                      ? const Icon(Icons.visibility_outlined)
                      : const Icon(Icons.visibility_off_outlined))
              : null,
          alignLabelWithHint: false,
          prefixIconConstraints:  BoxConstraints(
            maxHeight: 33.h,
            maxWidth: 35.w,
          ),
          prefixIcon: Container(
              margin: const EdgeInsets.only(right: 14, left: 5),
              child: SvgPicture.asset(widget.suffix_icon.toString()))),
    );
  }
}
