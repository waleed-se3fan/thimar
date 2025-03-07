import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salla_thumara/core/component/appbar.dart';
import 'package:salla_thumara/core/component/text_form_field.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/constatnt.dart';
import 'package:salla_thumara/core/utilities/images.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/core/widgets/modal_sheet.dart';
import 'package:salla_thumara/features/account/bloc.dart';
import 'package:salla_thumara/features/login/bloc.dart';
import 'package:salla_thumara/features/register/bloc.dart';
import 'package:salla_thumara/views/home_page/bottom_nav_bar.dart';
import 'package:salla_thumara/views/my_account_page/screens/chnage_password.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'تعديل البيانات'),
      body: BlocProvider(
        create: (BuildContext context) => AccountBloc(),
        child: BlocConsumer<AccountBloc, AccountState>(
          builder: (BuildContext context, state) {
            return Container(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocProvider(
                      create: (context) => AccountBloc(),
                      child: BlocBuilder<AccountBloc, AccountState>(
                        builder: (context, state) {
                          if (state is SuccessChangeImageState) {
                            return GestureDetector(
                                onTap: () async {
                                  context
                                      .read<AccountBloc>()
                                      .add(ChangeImageEvent());
                                },
                                child: Container(
                                  height: 90.h,
                                  width: 90.w,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(
                                              File(AccountBloc.image!.path))),
                                      borderRadius: BorderRadius.circular(30)),
                                ));
                          } else {
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<AccountBloc>()
                                    .add(ChangeImageEvent());
                              },
                              child: Container(
                                height: 90.h,
                                width: 90.w,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(LoginBloc.image!))),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      LoginBloc.fullName!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: 'Tajawal',
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 20.h,
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
                      height: 20.h,
                    ),
                    CustomTextFeild(
                        isPhoneNumber: true,
                        isPassword: false,
                        myController:
                            context.read<AccountBloc>().phoneController,
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
                      height: 20.h,
                    ),
                    BlocProvider(
                      create: (context) => RegisterBloc(),
                      child: BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, statee) {
                          return Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.mainColor),
                                      borderRadius:
                                          BorderRadius.circular(15.r)),
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
                                                fontSize: 15,
                                                fontFamily: 'Tajawal'),
                                          ),
                                        ],
                                      ),
                                      onPressed: () async {
                                        var bloc = context.read<RegisterBloc>();
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
                              statee is CitySelectorState
                                  ? Text(
                                      statee.city.toString(),
                                      style: const TextStyle(
                                          fontFamily: 'Tajawal'),
                                    )
                                  : const Text(
                                      'المنصورة',
                                      style: TextStyle(fontFamily: 'Tajawal'),
                                    )
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.mainColor),
                          borderRadius: BorderRadius.circular(15.r)),
                      padding: EdgeInsets.all(2.r),
                      child: MaterialButton(
                          child: Row(
                            children: [
                              SvgPicture.asset(AppImaes().unloack,
                                  height: 15.h),
                              SizedBox(
                                width: 15.w,
                              ),
                              const Text(
                                'كلمة المرور',
                                style: TextStyle(
                                    fontSize: 15, fontFamily: 'Tajawal'),
                              ),
                              const Spacer(),
                              SvgPicture.asset(
                                  'assets/images/icons/left_arrow.svg',
                                  height: 15.h),
                            ],
                          ),
                          onPressed: () async {
                            navigateTo(const ChangePasswordScreen());
                          }),
                    ),
                    //const Spacer(),
                    SizedBox(
                      height: height(context) / 4.h,
                    ),
                    BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                        if (state is LoadingUpdateProfileState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return SizedBox(
                            width: width(context),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.mainColor)),
                                onPressed: () {
                                  var bloc = context.read<AccountBloc>();
                                  context.read<AccountBloc>().add(
                                      EditPersonalDataEvent(
                                          AccountBloc.image!,
                                          bloc.userNameController.text,
                                          bloc.phoneController.text,
                                          12));
                                },
                                child: const Text(
                                  'تعديل البيانات',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Tajawal',
                                      fontWeight: FontWeight.bold),
                                )),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          },
          listener: (BuildContext context, Object? state) {
            state is SuccessUpdateProfileState
                ? navigateTo(BottomNavBar(), withHistory: false)
                : null;
          },
        ),
      ),
    );
  }
}
