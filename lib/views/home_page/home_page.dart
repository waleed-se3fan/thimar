import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/core/utilities/colors.dart';

import 'package:salla_thumara/data/catigories.dart';

import 'package:salla_thumara/features/home_page/bloc.dart';
import 'package:salla_thumara/views/home_page/widgets/animated_images.dart';
import 'package:salla_thumara/views/home_page/widgets/custom_textfield.dart';
import 'widgets/category_item.dart';
import 'widgets/catigories.dart';
import 'widgets/sections.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(15.r),
              child: Column(
                children: [
                  const CustomTextFormField(),
                  state is SuccessSearchState
                      ? SearchScreen(state.searchCategory)
                      : const Column(
                          children: [
                            CustomAnimatedImages(),
                            Sections(),
                            Categories(),
                          ],
                        )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  final List<Category>? myList;
  const SearchScreen(this.myList, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      height: MediaQuery.of(context).size.height / 1.1,
      child: myList!.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Icon(
                  CupertinoIcons.search,
                  color: AppColors.mainColor,
                  size: 70,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'لا توجد بيانات',
                  style: TextStyle(
                      color: Color(0xff4C8613),
                      fontFamily: 'Tajawal',
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          : GridView.builder(
              itemCount: myList!.length,
              itemBuilder: (_, i) {
                return CategoryItem(
                  i,
                  myList!,
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisExtent: 240.h),
            ),
    );
  }
}
