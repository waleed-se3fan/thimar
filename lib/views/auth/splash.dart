import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salla_thumara/core/widgets/logo.dart';
import 'package:salla_thumara/features/login/bloc.dart';
import 'package:salla_thumara/views/home_page/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utilities/navigation.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool islogin = false;

  Future getBool() async {
    final sharedPref = await SharedPreferences.getInstance();
    islogin = sharedPref.getBool('islogin')!;
  }

  @override
  void initState() {
    super.initState();

    getBool();
    LoginBloc.getData();
    Timer(
        const Duration(seconds: 2),
        () => islogin
            ? navigateTo(BottomNavBar())
            : navigateTo(const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/splash_ground.svg',
            fit: BoxFit.cover,
          ),
          myLogo(),
        ],
      ),
    );
  }
}
