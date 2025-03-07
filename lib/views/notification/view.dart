import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/core/component/main_text.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/constatnt.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomMainText(
          text: 'الاشعارات',
          fontSize: 20,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SizedBox(
          height: height(context) / 5,
          child: Column(
            children: [
              Icon(
                Icons.notifications_off_sharp,
                size: 50,
                color: AppColors.mainColor,
              ),
              SizedBox(
                height: 20.h,
              ),
              const CustomMainText(text: 'لا توجد اشعارات', fontSize: 22)
            ],
          ),
        ),
      ),
    );
  }
}
