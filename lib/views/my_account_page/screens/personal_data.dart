import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salla_thumara/core/component/text_form_field.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/constatnt.dart';
import 'package:salla_thumara/core/utilities/images.dart';
import 'package:salla_thumara/features/account/bloc.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => AccountBloc(),
        child: BlocConsumer<AccountBloc, AccountState>(
          builder: (BuildContext context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () async {
                      AccountBloc.image = (await ImagePicker.platform
                          .getImageFromSource(source: ImageSource.gallery));
                      print(AccountBloc.image!.path);
                    },
                    child: SvgPicture.asset('assets/images/personal.svg')),
                const Text(
                  'محمد علي',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Tajawal',
                      color: Colors.white),
                ),
                Text(
                  '+9668561489562',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Tajawal',
                      color: AppColors.lightmainColor2),
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextFeild(
                    isPassword: false,
                    isPhoneNumber: false,
                    myController:
                        context.read<AccountBloc>().userNameController,
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
                    myController: context.read<AccountBloc>().phoneController,
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
                              // context
                              //     .read<RegisterBloc>()
                              //     .add(ChoiseCountryEvent());
                              // bloc.cityValue = await showModalBottomSheet(
                              //   context: context,
                              //   builder: (mcontext) {
                              //     return modalButtomSheet(context);
                              //   },
                              // );
                            }),
                      ),
                    ),
                    // state is CitySelectorState
                    //     ? Text(
                    //         state.city.toString(),
                    //         style: const TextStyle(fontFamily: 'Tajawal'),
                    //       )
                    //     : Container(),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextFeild(
                    isPhoneNumber: false,
                    isPassword: true,
                    myController:
                        context.read<AccountBloc>().passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'ادخل كلمة المرور';
                      } else if (value.length < 8) {
                        return 'كلمة المرور لا يجب ان تقffل عن 8 خانات';
                      }
                      return null;
                    },
                    label_text: 'كلمة المرور',
                    suffix_icon: AppImaes().unloack,
                    width: width(context)),
                ElevatedButton(
                    onPressed: () {
                      var bloc = context.read<AccountBloc>();

                      context.read<AccountBloc>().add(EditPersonalDataEvent(
                          bloc.userNameController.text,
                          bloc.phoneController.text,
                          12));
                    },
                    child: const Text('تعديل البيانات'))
              ],
            );
          },
          listener: (BuildContext context, Object? state) {},
        ),
      ),
    );
  }
}
