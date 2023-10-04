import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salla_thumara/core/component/appbar.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/features/home_page/bloc.dart';

import '../home_page/widgets/category_item.dart';

class SectionDetailsScreen extends StatelessWidget {
  final String title;
  final int sectionIndex;
  const SectionDetailsScreen(
      {super.key, required this.title, required this.sectionIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            SizedBox(
              height: 45.h,
              child: TextFormField(
                onChanged: (value) =>
                    context.read<HomePageBloc>().add(SearchEvent(value)),
                decoration: InputDecoration(
                    fillColor: const Color.fromARGB(91, 209, 220, 196),
                    filled: true,
                    hintText: '   ابحث عن ماتريد؟',
                    labelStyle: TextStyle(
                        color: AppColors.grayColor,
                        fontFamily: 'Tajawal',
                        fontSize: 15),
                    prefixIcon: SvgPicture.asset(
                      'assets/images/search.svg',
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (c) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 2.2.h,
                                child: Column(
                                  children: [
                                    const Text('تصفية'),
                                    const Text('السعر'),
                                    RangeSlider(
                                        min: 10,
                                        max: 150,
                                        labels:
                                            const RangeLabels('start', 'end'),
                                        values: const RangeValues(50, 100),
                                        onChanged: (value) {}),
                                    const Divider(),
                                    const Text('الترتيب')
                                  ],
                                ),
                              );
                            });
                      },
                      child: SvgPicture.asset(
                        'assets/images/icons/controller.svg',
                      ),
                    ),
                    prefixIconConstraints:
                        const BoxConstraints.expand(height: 20, width: 35),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(14)))),
              ),
            ),
            SizedBox(height: 20.h),
            BlocProvider(
              create: (context) => HomePageBloc()
                ..add(GetSectionDetailsEvent(
                    HomePageBloc.section[sectionIndex].id)),
              child: BlocConsumer<HomePageBloc, HomePageState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return state is SuccessGetAllSectionDetailsState
                      ? Container(
                          padding: const EdgeInsets.all(12),
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: state.allCategories.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 30,
                                      mainAxisSpacing: 20,
                                      crossAxisCount: 2,
                                      mainAxisExtent: 240.h),
                              itemBuilder: (c, i) {
                                return CategoryItem(i, state.allCategories);
                              }),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
