import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/features/home_page/bloc.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: TextFormField(
        onChanged: (value) =>
            context.read<HomePageBloc>().add(SearchEvent(value)),
        decoration: InputDecoration(
            fillColor: const Color.fromARGB(91, 209, 220, 196),
            filled: true,
            hintText: '   ابحث عن ماتريد؟',
            labelStyle: TextStyle(
                color: AppColors.grayColor,
                fontFamily: 'Tajawal',
                fontSize: 15),
            prefixIcon: SvgPicture.asset(
              'assets/images/search.svg',
            ),
            prefixIconConstraints:
                const BoxConstraints.expand(height: 20, width: 35),
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(14)))),
      ),
    );
  }
}
