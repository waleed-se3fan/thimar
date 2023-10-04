import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/features/account/bloc.dart';
import 'package:salla_thumara/features/addresses/bloc.dart';
import 'package:salla_thumara/features/cart/bloc.dart';
import 'package:salla_thumara/features/favourite/bloc.dart';
import 'package:salla_thumara/features/google_map/bloc.dart';
import 'package:salla_thumara/features/login/bloc.dart';
import 'package:salla_thumara/features/register/bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/views/auth/splash.dart';
import 'core/utilities/navigation.dart';
import 'features/home_page/bloc.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.mainColor,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => HomePageBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => FavouriteBloc()),
        BlocProvider(create: (context) => AccountBloc()),
        BlocProvider(
            create: (context) => GoogleMapBloc()..add(GetGoogleMapEvent())),
        BlocProvider(create: (context) => AddressesBloc())
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
            useMaterial3: true,
          ),
          builder: (context, child) => GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Directionality(
                  textDirection: TextDirection.rtl, child: child!)),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
