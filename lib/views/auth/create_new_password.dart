import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/core/widgets/logo.dart';

import 'package:salla_thumara/core/component/buttom.dart';
import 'package:salla_thumara/core/component/text_form_field.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/constatnt.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/features/login/bloc.dart';
import 'package:salla_thumara/views/auth/login.dart';

import '../../core/component/main_text.dart';
import '../../core/component/submain_text.dart';
import '../../core/utilities/images.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  final String? phone;

  const CreateNewPasswordScreen(this.phone, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is CreateNewPasswordSuccsessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(state.message.toString())));

          navigateTo(const LoginScreen());
        } else if (state is LoginVerificationFailState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(state.message.toString())));
        } else if (state is PasseordNotMatchState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(state.message.toString())));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: context.read<LoginBloc>().formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                children: [
                  myLogo(),
                  SizedBox(
                    height: 21.h,
                  ),
                  const CustomMainText(
                    text: 'نسيت كلمة المرور',
                    fontSize: 16,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const CustomSubmainText(
                    text: 'أدخل كلمة المرور الجديدة',
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextFeild(
                      isPhoneNumber: false,
                      myController:
                          context.read<LoginBloc>().newPasswordController1,
                      isPassword: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ادخل كلمة المرور";
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
                      isPhoneNumber: false,
                      myController:
                          context.read<LoginBloc>().newPasswordController2,
                      isPassword: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل كلمة المرور';
                        }
                        return null;
                      },
                      label_text: 'كلمة المرور',
                      suffix_icon: AppImaes().unloack,
                      width: width(context)),
                  SizedBox(
                    height: 20.h,
                  ),
                  state is CreateNewPasswordSuccsessState ||
                          state is CreateNewPasswordFailState ||
                          state is PasseordNotMatchState ||
                          state is LoginInitial ||
                          state is NotValidateState
                      ? CustomButtom(
                          text: 'تغيير كلمة المرور',
                          function: () {
                            //   context.read<LoginBloc>().validateAndSave();
                            context.read<LoginBloc>().add(
                                CreateNewPasswordEvent(
                                    phone!,
                                    '1111',
                                    context
                                        .read<LoginBloc>()
                                        .newPasswordController1
                                        .text));
                            //  cubit.validateAndSave();
                          })
                      : state is CreateNewPasswordLoadingState
                          ? CustomButtom(
                              text: 'loading ...',
                              function: () {
                                //  cubit.validateAndSave();
                              })
                          : CustomButtom(
                              text: 'تغيير كلمة المرور',
                              function: () {
                                //   context.read<LoginBloc>().validateAndSave();
                                context.read<LoginBloc>().add(
                                    CreateNewPasswordEvent(
                                        phone!,
                                        '1111',
                                        context
                                            .read<LoginBloc>()
                                            .newPasswordController1
                                            .text));
                                //  cubit.validateAndSave();
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
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
