import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/images.dart';
import 'package:salla_thumara/views/favourite/view.dart';
import 'package:salla_thumara/views/home_page/home_page.dart';
import 'package:salla_thumara/views/home_page/widgets/custom_appbar.dart';
import 'package:salla_thumara/views/my_account_page/my_account_page.dart';
import '../../features/home_page/bloc.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});
  List<Widget> body = const [
    HomePage(),
    Text('Page 2'),
    Text('Page 3'),
    FavouriteScreen(),
    MyAccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    HomePageBloc bloc = BlocProvider.of(context);

    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: bloc.index == 0 ? const Appbar() : null,
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: context.read<HomePageBloc>().index,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedIconTheme: const IconThemeData(
                color: Colors.white,
              ),
              selectedLabelStyle: const TextStyle(
                color: Colors.white,
              ),
              unselectedLabelStyle: const TextStyle(color: Colors.white),
              backgroundColor: AppColors.mainColor,
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.white,
              onTap: (index) {
                context
                    .read<HomePageBloc>()
                    .add(BottomNavBarChangeEvent(index));
              },
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppImaes().home,
                      // ignore: deprecated_member_use
                      color: bloc.index == 0 ? Colors.white : null,
                    ),
                    label: 'الرئيسية'),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppImaes().lists,
                    // ignore: deprecated_member_use
                    color: bloc.index == 1 ? Colors.white : null,
                  ),
                  label: 'طلباتي',
                ),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppImaes().notification,
                      // ignore: deprecated_member_use
                      color: bloc.index == 2 ? Colors.white : null,
                    ),
                    label: 'الاشعارات'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppImaes().heart,
                      // ignore: deprecated_member_use
                      color: bloc.index == 3 ? Colors.white : null,
                    ),
                    label: 'المفضلة'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppImaes().profile,
                      // ignore: deprecated_member_use
                      color: bloc.index == 4 ? Colors.white : null,
                    ),
                    label: 'حسابي'),
              ]),
          body: Center(child: body[bloc.index]),
        );
      },
    );
  }
}
