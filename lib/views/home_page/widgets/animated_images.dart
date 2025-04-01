import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/core/component/shimmer.dart';
import 'package:salla_thumara/features/home_page/bloc.dart';

class CustomAnimatedImages extends StatefulWidget {
  const CustomAnimatedImages({super.key});

  @override
  State<CustomAnimatedImages> createState() => CustomAnimatedImagesState();
}

class CustomAnimatedImagesState extends State<CustomAnimatedImages> {
  int x = 0;
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool end = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage == 3) {
        end = true;
      } else if (_currentPage == 0) {
        end = false;
      }

      if (end == false) {
        _currentPage++;
        x++;
        setState(() {});
      } else {
        _currentPage--;
        x--;
        setState(() {});
      }
      setState(() {});

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInCirc,
      );
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc()..add(GetSliderImagesEvent()),
      child: BlocConsumer<HomePageBloc, HomePageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                    key: const Key('pageView'),
                    onPageChanged: (value) {
                      x = value;
                      setState(() {});
                      _currentPage = value;
                    },
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (c, i) {
                      return state is SuccesLoadingImages
                          ? Container(
                              padding: EdgeInsets.only(top: 25.h),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: '${state.images![i].image}',
                              ),
                            )
                          : const AnimatedImagesShimmer();
                    }),
                Container(
                  height: 20.h,
                  width: 100.w,
                  margin: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          const Color.fromRGBO(255, 255, 0, 1).withOpacity(.4)),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (c, i) {
                        return Container(
                          padding: EdgeInsets.all(4.r),
                          child: Icon(
                            Icons.circle,
                            size: 15,
                            color: _currentPage == i
                                ? Colors.white.withOpacity(.4)
                                : Colors.white,
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
