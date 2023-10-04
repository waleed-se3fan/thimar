import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/core/component/buttom.dart';
import 'package:salla_thumara/core/component/main_text.dart';
import 'package:salla_thumara/core/component/submain_text.dart';
import 'package:salla_thumara/core/component/text_form_field.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/constatnt.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/core/widgets/logo.dart';
import 'package:salla_thumara/features/login/bloc.dart';
import 'package:salla_thumara/views/auth/forget_password.dart';
import 'package:salla_thumara/views/home_page/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utilities/images.dart';

import 'register.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(state.message.toString())));
        } else if (state is LoginSuccesState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(state.message.toString())));
          final sharedPref = await SharedPreferences.getInstance();
          sharedPref.setBool('islogin', true);
          navigateTo(BottomNavBar());
        }
      },
      builder: (context, state) {
        var bloc = context.read<LoginBloc>();
        return SafeArea(
          child: Scaffold(
            body: Form(
              key: context.read<LoginBloc>().formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                children: [
                  myLogo(),
                  SizedBox(
                    height: 21.h,
                  ),
                  const CustomMainText(
                    text: 'مرحبا بك مرة اخري',
                    fontSize: 16,
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
                      isPhoneNumber: true,
                      isPassword: false,
                      myController:
                          context.read<LoginBloc>().loginPhoneController,
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
                  SizedBox(height: 8.h),
                  CustomTextFeild(
                      isLastLabel: true,
                      isPhoneNumber: false,
                      myController:
                          context.read<LoginBloc>().loginPasswordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ادخل كلمة المرور';
                        }
                        return null;
                      },
                      label_text: 'كلمة المرور',
                      suffix_icon: AppImaes().unloack,
                      width: width(context)),
                  SizedBox(
                    height: 22.h,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        navigateTo(const ForgetpasswordScreen());
                      },
                      child: const Text(
                        'نسيت كلمة المرور ؟',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'Tajawal'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  state is LoginLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomButtom(
                          text: 'تسجيل الدخول',
                          function: () async {
                            context.read<LoginBloc>().add(LoginToAppEvent(
                                bloc.loginPhoneController.text,
                                bloc.loginPasswordController.text));
                          }),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        navigateTo(const RegisterScreen());
                      },
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'ليس لديك حساب ؟ ',
                            style: TextStyle(
                                color: AppColors.grayColor,
                                fontSize: 15,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'تسجيل الان',
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
