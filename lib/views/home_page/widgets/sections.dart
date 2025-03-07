import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/core/component/shimmer.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/features/home_page/bloc.dart';
import 'package:salla_thumara/views/section_details/view.dart';

class Sections extends StatelessWidget {
  const Sections({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc()..add(GetSectionImagesEvent()),
      child: BlocConsumer<HomePageBloc, HomePageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('الاقسام')],
              ),
              SizedBox(
                height: 100.h,
                child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (c, i) {
                      return SizedBox(
                        width: 100,
                        child: state is SuccessSectionState
                            ? InkWell(
                                onTap: () {
                                  navigateTo(SectionDetailsScreen(
                                    title: HomePageBloc.section[i].name,
                                    sectionIndex: i,
                                  ));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      height: 50,
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                state.image[i].image,
                                              )),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(state.image[i].name)
                                  ],
                                ),
                              )
                            : const SectionShimmer(),
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
