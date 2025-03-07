import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salla_thumara/core/component/appbar.dart';
import 'package:salla_thumara/core/component/buttom.dart';
import 'package:salla_thumara/core/component/main_text.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/constatnt.dart';
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
                                    MediaQuery.of(context).size.height / 2.h,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Center(
                                        child: CustomMainText(
                                            text: 'تصفية', fontSize: 17),
                                      ),
                                      const Divider(),
                                      const Text(
                                        'السعر',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      BlocProvider(
                                        create: (context) => HomePageBloc(),
                                        child: BlocBuilder<HomePageBloc,
                                            HomePageState>(
                                          builder: (context, state) {
                                            return state
                                                    is ChangeRangeSliderState
                                                ? Column(
                                                    children: [
                                                      RangeSlider(
                                                          min: 0,
                                                          max: 100,
                                                          labels:
                                                              const RangeLabels(
                                                                  'start',
                                                                  'end'),
                                                          values: RangeValues(
                                                              state.start,
                                                              state.end),
                                                          onChanged: (value) => context
                                                              .read<
                                                                  HomePageBloc>()
                                                              .add(ChangeRangeSliderEvent(
                                                                  value.start,
                                                                  value.end))),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 20),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                '${state.start.toInt()}  ر.س'),
                                                            const Spacer(),
                                                            Text(
                                                                '${state.end.toInt()}  ر.س'),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      RangeSlider(
                                                          min: 0,
                                                          max: 100,
                                                          labels:
                                                              const RangeLabels(
                                                                  'start',
                                                                  'end'),
                                                          values:
                                                              const RangeValues(
                                                                  0, 100),
                                                          onChanged: (value) => context
                                                              .read<
                                                                  HomePageBloc>()
                                                              .add(ChangeRangeSliderEvent(
                                                                  value.start,
                                                                  value.end))),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20),
                                                        child: Row(
                                                          children: [
                                                            Text('${0}  ر.س'),
                                                            Spacer(),
                                                            Text('${100}  ر.س'),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  );
                                          },
                                        ),
                                      ),
                                      const Divider(),
                                      const Text(
                                        'الترتيب',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      BlocProvider(
                                          create: (context) => HomePageBloc(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              BlocBuilder<HomePageBloc,
                                                  HomePageState>(
                                                builder: (context, state) {
                                                  return state is CheckBoxState
                                                      ? Row(
                                                          children: [
                                                            Checkbox(
                                                                value:
                                                                    state.check,
                                                                onChanged: (value) => context
                                                                    .read<
                                                                        HomePageBloc>()
                                                                    .add(CheckBoxEvent(
                                                                        value!))),
                                                            const Text(
                                                                'من السعر الأقل للأعلي')
                                                          ],
                                                        )
                                                      : Row(
                                                          children: [
                                                            Checkbox(
                                                                value:
                                                                    HomePageBloc
                                                                        .check,
                                                                onChanged: (value) => context
                                                                    .read<
                                                                        HomePageBloc>()
                                                                    .add(CheckBoxEvent(
                                                                        value!))),
                                                            const Text(
                                                                'من السعر الأقل للأعلي')
                                                          ],
                                                        );
                                                },
                                              ),
                                              BlocBuilder<HomePageBloc,
                                                  HomePageState>(
                                                builder: (context, state) {
                                                  return state is CheckBoxState
                                                      ? Row(
                                                          children: [
                                                            Checkbox(
                                                                value: !state
                                                                    .check,
                                                                onChanged: (value) => context
                                                                    .read<
                                                                        HomePageBloc>()
                                                                    .add(CheckBoxEvent(
                                                                        !value!))),
                                                            const Text(
                                                                'من السعر الأقل للأعلي')
                                                          ],
                                                        )
                                                      : Row(
                                                          children: [
                                                            Checkbox(
                                                                value:
                                                                    !HomePageBloc
                                                                        .check,
                                                                onChanged: (value) => context
                                                                    .read<
                                                                        HomePageBloc>()
                                                                    .add(CheckBoxEvent(
                                                                        !value!))),
                                                            const Text(
                                                                'من السعر الأقل للأعلي')
                                                          ],
                                                        );
                                                },
                                              ),
                                            ],
                                          )),
                                      BlocProvider.value(
                                        value: BlocProvider.of<HomePageBloc>(
                                            context),
                                        child: BlocConsumer<HomePageBloc,
                                            HomePageState>(
                                          listener: (context, state) {
                                            if (state is SuccessFilterData) {
                                              Navigator.pop(context);
                                            } else {
                                              null;
                                            }
                                          },
                                          builder: (context, state) {
                                            return state is LoadingFilterData
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : SizedBox(
                                                    width: width(context),
                                                    child: CustomButtom(
                                                        text: 'تطبيق',
                                                        function: () {
                                                          context
                                                              .read<
                                                                  HomePageBloc>()
                                                              .add(FilterDataEvent(
                                                                  sectionIndex));
                                                        }),
                                                  );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
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
            BlocProvider.value(
              value: BlocProvider.of<HomePageBloc>(context)
                ..add(GetSectionDetailsEvent(
                    HomePageBloc.section[sectionIndex].id)),
              child: BlocBuilder<HomePageBloc, HomePageState>(
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
                      : state is SuccessFilterData
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
            )
          ],
        ),
      ),
    );
  }
}
