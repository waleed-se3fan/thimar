import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/core/component/appbar.dart';
import 'package:salla_thumara/core/component/text_form_field.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/constatnt.dart';
import 'package:salla_thumara/core/utilities/images.dart';
import 'package:salla_thumara/features/account/bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'تغيير كلمة المرور'),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 8.h,
            ),
            CustomTextFeild(
                isPassword: false,
                isPhoneNumber: false,
                myController: context.read<AccountBloc>().oldpasswordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'ادخل كلمة المرور الحالية';
                  }
                  return null;
                },
                label_text: 'كلمة المرور الحالية',
                suffix_icon: AppImaes().unloack,
                width: width(context)),
            SizedBox(
              height: 20.h,
            ),
            CustomTextFeild(
                isPassword: false,
                isPhoneNumber: false,
                myController: context.read<AccountBloc>().newpasswordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'ادخل كلمة المرور الجديدة';
                  }
                  return null;
                },
                label_text: 'كلمة المرور الجديدة',
                suffix_icon: AppImaes().unloack,
                width: width(context)),
            SizedBox(
              height: 20.h,
            ),
            CustomTextFeild(
                isPassword: false,
                isPhoneNumber: false,
                // myController:
                //     context.read<AccountBloc>().userNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'ادخل اسم المستخدم';
                  }
                  return null;
                },
                label_text: 'كلمة المرور الجديدة',
                suffix_icon: AppImaes().unloack,
                width: width(context)),
            const Spacer(),
            BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                return state is LoadingEditPasswordState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        width: width(context),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.mainColor)),
                            onPressed: () {
                              var bloc = context.read<AccountBloc>();
                              context.read<AccountBloc>().add(EditPasswordEvent(
                                    bloc.oldpasswordController.text,
                                    bloc.newpasswordController.text,
                                  ));
                            },
                            child: const Text(
                              'تغيير كلمة المرور',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Tajawal',
                                  fontWeight: FontWeight.bold),
                            )),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
