import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salla_thumara/core/component/appbar.dart';
import 'package:salla_thumara/core/utilities/images.dart';
import 'package:salla_thumara/features/account/bloc.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'عن التطبيق'),
      body: BlocProvider(
          create: (context) => AccountBloc()..add(GetAboutAppEvent()),
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              return state is SuccessGetAboutAppState
                  ? Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Center(
                            child: SvgPicture.asset(
                          AppImaes().logo,
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        )),
                        SizedBox(
                          height: 25.h,
                        ),
                        Center(child: Text(state.message.substring(25, 228))),
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
          )),
    );
  }
}
