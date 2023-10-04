import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/core/component/buttom.dart';
import 'package:salla_thumara/core/component/main_text.dart';
import 'package:salla_thumara/core/component/submain_text.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/core/widgets/logo.dart';
import 'package:salla_thumara/features/register/bloc.dart';

import 'package:salla_thumara/views/auth/login.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class EmailVerificationScreen extends StatelessWidget {
  final String phone;
  const EmailVerificationScreen(this.phone, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is VerificationScuceesState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(state.message.toString())));

          navigateTo(const LoginScreen(), withHistory: false);
        } else if (state is VerificationFailState) {
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
                  text: 'تفعيل الحساب ',
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
                            color: AppColors.grayColor,
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
                    context.read<RegisterBloc>().otpVerificationCode.text =
                        output;
                    context
                        .read<RegisterBloc>()
                        .add(EmailVerificationEvent(phone));
                    // Your logic with pin code
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                state is RegisterInitial
                    ? CustomButtom(
                        text: 'تأكيد الكود',
                        function: () {
                          context
                              .read<RegisterBloc>()
                              .add(EmailVerificationEvent(phone));
                        })
                    : state is VerificationLoadingState
                        ? CustomButtom(text: 'loading', function: () {})
                        : CustomButtom(
                            text: 'تأكيد الكود',
                            function: () {
                              context
                                  .read<RegisterBloc>()
                                  .add(EmailVerificationEvent(phone));
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
                state is RegisterInitial || state is CountDownTimerAppearState
                    ? CircularCountDownTimer(
                        autoStart: true,
                        controller: context.read<RegisterBloc>().controller,
                        isReverse: true,
                        width: 60.w,
                        height: 60.h,
                        duration: 20,
                        fillColor: AppColors.submainColor,
                        onComplete: () {
                          context.read<RegisterBloc>().controller.restart();
                          context
                              .read<RegisterBloc>()
                              .add(CountDownTimerDisapearEvent());
                        },
                        ringColor: AppColors.mainColor)
                    : Container(),
                GestureDetector(
                  onTap: () {
                    context
                        .read<RegisterBloc>()
                        .add(CountDownTimerApearEvent());
                    context.read<RegisterBloc>().controller.restart();

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
                      navigateTo(const LoginScreen(), withHistory: false);
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
