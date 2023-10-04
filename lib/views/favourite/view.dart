import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/features/favourite/bloc.dart';
import 'package:salla_thumara/views/home_page/widgets/category_item.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('المفضلة'),
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
                      : state is NotInternetState
                          ? const Center(
                              child: Text('لايوجد اتصال بالانترنت'),
                            )
                          : state is LoadingAddtoFavourite
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                );
                })));
  }
}
