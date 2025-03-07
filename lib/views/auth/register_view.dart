// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salla_thumara/core/component/buttom.dart';
import 'package:salla_thumara/core/component/text_form_field.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/constatnt.dart';
import 'package:salla_thumara/core/utilities/images.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/core/widgets/logo.dart';
import 'package:salla_thumara/core/widgets/modal_sheet.dart';
import 'package:salla_thumara/features/register/bloc.dart';
import 'package:salla_thumara/views/auth/email_verification.dart';

import '../../core/component/main_text.dart';
import '../../core/component/submain_text.dart';
import 'login.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(state.state.toString())));
        } else if (state is RegisterSuccesState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(state.state)));

          navigateTo(EmailVerificationScreen(
              context.read<RegisterBloc>().registerphoneController.text));
        }
      },
      builder: (context, state) {
        var bloc = context.read<RegisterBloc>();
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: bloc.formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                children: [
                  myLogo(),
                  SizedBox(
                    height: 21.h,
                  ),
                  const CustomMainText(
                    fontSize: 16,
                    text: 'مرحبا بك مرة اخري',
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const CustomSubmainText(
                    text: 'يمكنك تسجيل الدخول الان',
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  CustomTextFeild(
                      isPassword: false,
                      isPhoneNumber: false,
                      myController: bloc.registernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل اسم المستخدم';
                        }
                        return null;
                      },
                      label_text: 'اسم المستخدم',
                      suffix_icon: AppImaes().user,
                      width: width(context)),
                  SizedBox(
                    height: 8.h,
                  ),
                  CustomTextFeild(
                      isPhoneNumber: true,
                      isPassword: false,
                      myController:
                          context.read<RegisterBloc>().registerphoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل رقم الجوال';
                        }
                        return null;
                      },
                      label_text: 'رقم الجوال',
                      inputType: TextInputType.phone,
                      suffix_icon: 'assets/images/Phone.svg',
                      width: width(context) / 1.8),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.submainColor),
                              borderRadius: BorderRadius.circular(15.r)),
                          padding: EdgeInsets.all(2.r),
                          child: MaterialButton(
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppImaes().report,
                                      height: 15.h),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  const Text(
                                    'المدينة',
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'Tajawal'),
                                  ),
                                ],
                              ),
                              onPressed: () async {
                                context
                                    .read<RegisterBloc>()
                                    .add(ChoiseCountryEvent());
                                RegisterBloc.cityValue =
                                    await showModalBottomSheet(
                                  context: context,
                                  builder: (mcontext) {
                                    return modalButtomSheet(context);
                                  },
                                );
                              }),
                        ),
                      ),
                      state is CitySelectorState
                          ? Text(
                              state.city.toString(),
                              style: const TextStyle(fontFamily: 'Tajawal'),
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  CustomTextFeild(
                      isPhoneNumber: false,
                      isPassword: true,
                      myController: context
                          .read<RegisterBloc>()
                          .registerpasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل كلمة المرور';
                        } else if (value.length < 8) {
                          return 'كلمة المرور لا يجب ان تقل عن 8 خانات';
                        }
                        return null;
                      },
                      label_text: 'كلمة المرور',
                      suffix_icon: AppImaes().unloack,
                      width: width(context)),
                  SizedBox(
                    height: 8.h,
                  ),
                  CustomTextFeild(
                      isLastLabel: true,
                      isPhoneNumber: false,
                      isPassword: true,
                      myController: context
                          .read<RegisterBloc>()
                          .registerconfirmpasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل كلمة المرور';
                        } else if (context
                                .read<RegisterBloc>()
                                .registerpasswordController
                                .text !=
                            context
                                .read<RegisterBloc>()
                                .registerconfirmpasswordController
                                .text) {
                          return 'كلمة المرور غير متطابقة';
                        }
                        return null;
                      },
                      label_text: 'كلمة المرور',
                      suffix_icon: AppImaes().unloack,
                      width: width(context)),
                  SizedBox(
                    height: 8.h,
                  ),
                  state is RegisterLoadingState
                      ? CustomButtom(text: 'loading ', function: () {})
                      : CustomButtom(
                          text: 'تسجيل ',
                          function: () async {
                            var bloc = context.read<RegisterBloc>();

                            context.read<RegisterBloc>().add(
                                GetRegisterDataEvent(
                                    bloc.registernameController.text,
                                    bloc.registerphoneController.text,
                                    RegisterBloc.cityId!));
                          }),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        navigateTo(const LoginScreen());
                      },
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'لديك حساب بالفعل ؟ ',
                            style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 15,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'تسجيل الدخول',
                            style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 16,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.bold)),
                      ])),
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
