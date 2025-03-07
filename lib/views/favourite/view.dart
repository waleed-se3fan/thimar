import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/core/component/main_text.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/features/favourite/bloc.dart';
import 'package:salla_thumara/views/home_page/widgets/category_item.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const CustomMainText(
            text: 'المفضلة',
            fontSize: 20,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: BlocProvider(
            create: (context) => FavouriteBloc()..add(GetFavouriteEvent()),
            child: BlocConsumer<FavouriteBloc, FavouriteState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return state is SuccessFavouritesState
                      ? Container(
                          padding: const EdgeInsets.all(12),
                          child: GridView.builder(
                              itemCount: state.favourites.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 20.h,
                                      crossAxisCount: 2,
                                      mainAxisExtent: 240.h),
                              itemBuilder: (c, i) {
                                return CategoryItem(i, state.favourites);
                              }),
                        )
                      : state is LoadingAddtoFavourite
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : state is EmptyFavouriteState
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.do_disturb_alt_outlined,
                                        color: AppColors.mainColor,
                                        size: 45,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      const CustomMainText(
                                          text: 'لا يوجد شئ في المفضلة',
                                          fontSize: 19)
                                    ],
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                );
                })));
  }
}
