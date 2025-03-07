import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/data/catigories.dart';
import 'package:salla_thumara/features/cart/bloc.dart';
import 'package:salla_thumara/views/product_details/view.dart';

class CategoryItem extends StatelessWidget {
  final int index;
  final List<Category> list;
  const CategoryItem(this.index, this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        width: 15,
        child: GestureDetector(
          onTap: () {
            navigateTo(ProductDetails(product: list[index], categoryId: index),
                withHistory: true);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Container(
                      height: 100.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(list[index].main_image),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              topLeft: Radius.circular(8))),
                      child: Text(
                        list[index].discount.toString(),
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'Tajawal'),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                list[index].title.toString(),
                style: TextStyle(
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Tajawal'),
              ),
              Text(
                'السعر / 1كجم',
                style: TextStyle(
                    color: AppColors.grayColor2,
                    fontSize: 12,
                    fontFamily: 'Tajawal'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${list[index].price.toString()}ر.س',
                    //overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 16,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${list[index].price_before_discount.toString()}ر.س',
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.lightmainColor,
                      color: AppColors.lightmainColor,
                      fontSize: 14,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.lightmainColor),
                      child: Icon(
                        Icons.add,
                        color: AppColors.whiteColor,
                      ))
                ],
              ),
              Center(
                  child: BlocConsumer<CartBloc, CartState>(
                listener: (context, state) {
                  // if (state is SuccessStoretoCartState) {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     content: Text(
                  //       state.message,
                  //     ),
                  //     duration: Duration(milliseconds: 200),
                  //   ));
                  // } else {
                  //   print('*--**-*-*-');
                  // }
                },
                builder: (context, statee) {
                  return statee is LoadingStoretoCartState &&
                          CartBloc.storeIndex == index
                      ? const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          child: Center(child: LinearProgressIndicator()))
                      : list[index].amount == 0
                          ? ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.whiteColor)),
                              onPressed: () {},
                              child: const Text(
                                'تم نفاذ الكمية',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold),
                              ))
                          : ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.lightmainColor)),
                              onPressed: () {
                                context.read<CartBloc>().add(StoreToCartEvent(
                                    list[index].id.toInt(), index));
                              },
                              child: Text(
                                'اضف للسلة',
                                style: TextStyle(color: AppColors.whiteColor),
                              ));
                },
              ))
            ],
          ),
        ));
  }
}
