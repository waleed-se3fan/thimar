import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/features/addresses/bloc.dart';
import 'package:salla_thumara/features/login/bloc.dart';
import 'package:salla_thumara/views/auth/login.dart';
import 'package:salla_thumara/views/my_account_page/screens/about_screen.dart';
import 'package:salla_thumara/views/my_account_page/screens/addresses.dart';

import 'package:salla_thumara/views/my_account_page/screens/personal_data.dart';
import 'package:salla_thumara/views/my_account_page/screens/repeat_quistion.dart';
import 'package:salla_thumara/views/my_account_page/screens/suggestion.dart';
import 'package:salla_thumara/views/my_account_page/screens/terms.dart';
import 'package:salla_thumara/views/my_account_page/screens/wallet_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Data> data = [
      Data('assets/images/icons/user.svg', 'البيانات الشخصية',
          const PersonalData()),
      Data('assets/images/icons/wallet.svg', 'المحفظة', const WalletSceen()),
      Data('assets/images/icons/location.svg', 'العناوين',
          const AddressesScreen()),
      Data('assets/images/icons/paid.svg', 'اسئلة متكررة',
          const RepeatQuistionScreen()),
      Data('assets/images/icons/Question.svg', 'سياسة الخصوصية', Container()),
      Data('assets/images/icons/user.svg', 'تواصل معنا', Container()),
      Data('assets/images/icons/Calling.svg', 'الشكاوي والاقتراحات',
          const ComplaintsAndSuggestionScreen()),
      Data('assets/images/icons/Note.svg', 'مشاركة التطبيق', Container()),
      Data('assets/images/icons/share.svg', 'عن التطبيق', const AboutScreen()),
      Data('assets/images/icons/user.svg', 'الشروط والاحكام',
          const TermsScreen()),
      Data('assets/images/icons/Star.svg', 'تقييم التطبيق', Container()),
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height / 3.7,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'حسابي',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Tajawal',
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          height: 70.h,
                          width: 70.w,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: Image.network(
                            LoginBloc.image!,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          LoginBloc.fullName!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'Tajawal',
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          LoginBloc.phone!,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Tajawal',
                              color: AppColors.lightmainColor2),
                        ),
                      ],
                    ),
                  )),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (c, i) {
                    return InkWell(
                      onTap: () {
                        i == 2
                            ? context
                                .read<AddressesBloc>()
                                .add(GetAllAdressessEvent())
                            : null;

                        i == data.length - 4
                            ? Share.share(
                                'https://play.google.com/store/apps/details?id=com.alalmiya.thamra&hl=ar&gl=US')
                            : i == data.length - 1
                                ? launchUrlString(
                                    'https://play.google.com/store/apps/details?id=com.alalmiya.thamra&hl=ar&gl=US')
                                : navigateTo(data[i].widget, withHistory: true);
                      },
                      child: ListTile(
                        leading: SvgPicture.asset(data[i].icon),
                        title: Text(
                          data[i].title,
                          style: const TextStyle(
                              color: Color(0xff4C8613),
                              fontFamily: 'Tajawal',
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: SvgPicture.asset(
                            'assets/images/icons/left_arrow.svg'),
                      ),
                    );
                  }),
              Container(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: () async {
                    final sharedPref = await SharedPreferences.getInstance();
                    sharedPref.setBool('islogin', false).then((value) {
                      navigateTo(LoginScreen());
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'تسجيل الخروج',
                        style: TextStyle(
                            color: Color(0xff4C8613),
                            fontFamily: 'Tajawal',
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      SvgPicture.asset('assets/images/icons/turn_off.svg')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Data {
  String icon;
  String title;
  Widget widget;
  Data(this.icon, this.title, this.widget);
}
