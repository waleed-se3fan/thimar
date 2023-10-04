import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/core/component/buttom.dart';
import 'package:salla_thumara/core/component/main_text.dart';
import 'package:salla_thumara/core/component/submain_text.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/core/widgets/logo.dart';
import 'package:salla_thumara/views/auth/create_new_password.dart';
import 'package:salla_thumara/views/auth/login.dart';

import '../../features/login/bloc.dart';

class CodeConformationScreen extends StatelessWidget {
  final String phone;

  const CodeConformationScreen(this.phone, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginVerificationScuceesState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(state.message.toString())));

          navigateTo(CreateNewPasswordScreen(phone));
        } else if (state is LoginVerificationFailState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(state.message.toString())));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              children: [
                myLogo(),
                SizedBox(
                  height: 21.h,
                ),
                const CustomMainText(
                  text: 'نسيت كلمة المرور ',
                  fontSize: 16,
                ),
                SizedBox(
                  height: 8.h,
                ),
                SizedBox(
                  height: 8.h,
                ),
                GestureDetector(
                  onTap: () {},
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text:
                            'أدخل الكود المكون من 4 أرقام المرسل علي رقم الجوال $phone    ',
                        style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 15,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: 'تغيير رقم الجوال',
                        style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 15,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline))
                  ])),
                ),
                SizedBox(
                  height: 18.h,
                ),
                PinCodeFields(
                  length: 4,
                  fieldBorderStyle: FieldBorderStyle.square,
                  responsive: false,
                  fieldHeight: 50.0.h,
                  fieldWidth: 55.0.w,
                  borderWidth: 1.w,
                  borderRadius: BorderRadius.circular(12.0),
                  keyboardType: TextInputType.number,
                  autoHideKeyboard: false,
                  borderColor: Colors.black12,
                  activeBorderColor: AppColors.mainColor,
                  onComplete: (output) {
                    context.read<LoginBloc>().otpVerificationCode.text = output;
                    context.read<LoginBloc>().add(LoginEmailVerificationEvent(
                        phone,
                        context.read<LoginBloc>().otpVerificationCode.text));
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                state is LoginInitial
                    ? CustomButtom(
                        text: 'تأكيد الكود',
                        function: () {
                          context.read<LoginBloc>().add(
                              LoginEmailVerificationEvent(
                                  phone,
                                  context
                                      .read<LoginBloc>()
                                      .otpVerificationCode
                                      .text));
                        })
                    : state is LoginVerificationLoadingState
                        ? CustomButtom(text: 'loading', function: () {})
                        : CustomButtom(
                            text: 'تأكيد الكود',
                            function: () {
                              context.read<LoginBloc>().add(
                                  LoginEmailVerificationEvent(
                                      phone,
                                      context
                                          .read<LoginBloc>()
                                          .otpVerificationCode
                                          .text));
                            }),
                SizedBox(
                  height: 20.h,
                ),
                const Center(
                  child: CustomSubmainText(
                    text: 'لم تستلم الكود ؟\n يمكنك اعادة ارسال الكود بعد ',
                    align: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                state is LoginInitial || state is LoginCountDownTimerAppearState
                    ? CircularCountDownTimer(
                        autoStart: true,
                        controller: context.read<LoginBloc>().controller,
                        isReverse: true,
                        width: 60.w,
                        height: 60.h,
                        duration: 25,
                        fillColor: AppColors.submainColor,
                        onComplete: () {
                          context.read<LoginBloc>().controller.restart();
                          context
                              .read<LoginBloc>()
                              .add(LoginCountDownTimerDisapearEvent());
                        },
                        ringColor: AppColors.mainColor)
                    : Container(),
                GestureDetector(
                  onTap: () {
                    context
                        .read<LoginBloc>()
                        .add(LoginCountDownTimerApearEvent());
                    context.read<LoginBloc>().controller.restart();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('تم الارسال بنجاح'),
                      duration: Duration(seconds: 1),
                    ));
                  },
                  child: Container(
                    height: 50,
                    margin:
                        EdgeInsets.symmetric(horizontal: 80.h, vertical: 25.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.mainColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: const CustomMainText(
                      text: 'اعادة الارسال',
                      fontSize: 16,
                      align: TextAlign.center,
                    ),
                  ),
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
        );
      },
    );
  }
}
