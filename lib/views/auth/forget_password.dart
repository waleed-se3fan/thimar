import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/core/widgets/logo.dart';
import 'package:salla_thumara/features/login/bloc.dart';
import 'package:salla_thumara/core/component/buttom.dart';
import 'package:salla_thumara/core/component/text_form_field.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/constatnt.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/views/auth/code_information.dart';
import 'package:salla_thumara/views/auth/login.dart';
import '../../core/component/main_text.dart';
import '../../core/component/submain_text.dart';

class ForgetpasswordScreen extends StatelessWidget {
  const ForgetpasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is ForgitPasswordSuccesState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message.toString()),
            duration: const Duration(seconds: 1),
          ));
          navigateTo(CodeConformationScreen(
              context.read<LoginBloc>().forgetPasswordPhoneController.text));
        } else if (state is ForgetPasswordFailState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message.toString()),
              duration: const Duration(seconds: 1)));
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
                    text: 'أدخل رقم الجوال المرتبط بحسابك',
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 18,
                        child: CustomTextFeild(
                            isPhoneNumber: true,
                            isPassword: false,
                            myController: context
                                .read<LoginBloc>()
                                .forgetPasswordPhoneController,
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  state is ForgitPasswordSuccesState ||
                          state is ForgetPasswordFailState ||
                          state is LoginInitial ||
                          state is NotValidateState
                      ? CustomButtom(
                          text: 'تاكيد رقم الجوال',
                          function: () {
                            //   context.read<LoginBloc>().validateAndSave();
                            context.read<LoginBloc>().add(ForegtPasswordEvent(
                                context
                                    .read<LoginBloc>()
                                    .forgetPasswordPhoneController
                                    .text));
                          })
                      : state is ForgitPasswordLoadingState
                          ? CustomButtom(
                              text: 'loading',
                              function: () {
                                //  cubit.validateAndSave();
                              })
                          : CustomButtom(
                              text: 'تاكيد رقم الجوال',
                              function: () {
                                //   context.read<LoginBloc>().validateAndSave();
                                context.read<LoginBloc>().add(
                                    ForegtPasswordEvent(context
                                        .read<LoginBloc>()
                                        .forgetPasswordPhoneController
                                        .text));
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
