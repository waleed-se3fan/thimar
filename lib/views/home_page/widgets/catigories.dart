import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/features/home_page/bloc.dart';

import 'category_item.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.topRight,
          child: Text(
            'الاصناف',
          ),
        ),
        BlocProvider(
          create: (context) => HomePageBloc(),
          child: BlocConsumer<HomePageBloc, HomePageState>(
            listener: (context, state) {},
            builder: (context, state) {
              state is HomePageInitial
                  ? context.read<HomePageBloc>().add(GetAllCategoriesEvent())
                  : null;
              return state is SuccessGetAllCategories
                  ? GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: 7,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 20,
                          crossAxisCount: 2,
                          mainAxisExtent: 220.h),
                      itemBuilder: (c, i) {
                        return CategoryItem(i, state.allCategories);
                      })
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
      ],
    );
  }
}
