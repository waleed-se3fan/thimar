import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salla_thumara/core/component/main_text.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/data/catigories.dart';
import 'package:salla_thumara/features/cart/bloc.dart';
import 'package:salla_thumara/features/favourite/bloc.dart';
import 'package:salla_thumara/features/home_page/bloc.dart';
import 'package:salla_thumara/views/cart/cart.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:salla_thumara/views/home_page/bottom_nav_bar.dart';

class ProductDetails extends StatefulWidget {
  final Category product;
  final int categoryId;
  const ProductDetails(
      {super.key, required this.product, required this.categoryId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.mainColor,
          ),
        ),
        actions: [
          BlocProvider(
            create: (context) => FavouriteBloc(),
            child: BlocConsumer<FavouriteBloc, FavouriteState>(
              listener: (context, state) {
                state is SuccessAddtoFavourite
                    ? ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)))
                    : state is SuccessRemoveFromFavourite
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)))
                        : null;
              },
              builder: (context, state) {
                return widget.product.is_favorite
                    ? IconButton(
                        onPressed: () {
                          HomePageBloc.list1![widget.categoryId].is_favorite =
                              false;
                          setState(() {});

                          context
                              .read<FavouriteBloc>()
                              .add(RemoveFromFavourite(widget.categoryId));
                        },
                        icon: const Icon(
                          CupertinoIcons.heart_fill,
                          color: Colors.red,
                        ))
                    : IconButton(
                        onPressed: () {
                          HomePageBloc.list1![widget.categoryId].is_favorite =
                              true;
                          setState(() {});
                          context
                              .read<FavouriteBloc>()
                              .add(AddToFavourite(widget.categoryId));
                        },
                        icon: Icon(
                          CupertinoIcons.heart,
                          color: AppColors.mainColor,
                        ));
              },
            ),
          ),
        ],
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          context.read<CartBloc>().add(
              StoreToCartEvent(widget.product.id.toInt(), widget.categoryId));
          showModalBottomSheet(
              context: context,
              builder: (c) {
                return Container(
                  padding: const EdgeInsets.all(18),
                  height: MediaQuery.of(context).size.height / 4.5,
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(50))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/images/tick.svg'),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'تم اضافة المنتج بنجاح',
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainColor),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        widget.product.main_image))),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            children: [
                              Text(
                                widget.product.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.mainColor,
                                    fontFamily: 'Tajawal',
                                    fontSize: 12),
                              ),
                              const Text(
                                'الكمية ' '1',
                                style: TextStyle(
                                    color: Color(0xff7E7E7E),
                                    fontFamily: 'Tajawal',
                                    fontSize: 12),
                              ),
                              Text('${widget.product.price}ر.س',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.mainColor,
                                      fontFamily: 'Tajawal',
                                      fontSize: 12)),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.mainColor)),
                                  onPressed: () {
                                    navigateTo(const CartScreen());
                                  },
                                  child: const Text(
                                    'التحويل الي السلة ',
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    navigateTo(BottomNavBar(),
                                        withHistory: false);
                                  },
                                  child: const Text('تصفح العروض'))),
                        ],
                      )
                    ],
                  ),
                );
              });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          color: AppColors.mainColor,
          height: 50.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.5),
                          borderRadius: BorderRadius.circular(12)),
                      child: SvgPicture.asset('assets/images/shopping.svg')),
                  const SizedBox(
                    width: 14,
                  ),
                  const Text(
                    'اضافة الي السلة',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Tajawal',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                '${widget.product.price} ر.س',
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Tajawal',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(widget.product.main_image),
                                fit: BoxFit.fill),
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(15))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomMainText(
                              text: widget.product.title, fontSize: 22),
                          Row(
                            children: [
                              Text(
                                '${widget.product.discount.toString()} %',
                                style: const TextStyle(
                                  color: Color(0xffFF0000),
                                  fontFamily: 'Tajawal',
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              CustomMainText(
                                  text:
                                      '${widget.product.price.toString()} ر.س',
                                  fontSize: 22),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${widget.product.price_before_discount} ر.س',
                                style: const TextStyle(
                                    color: Color(0xff4C8613),
                                    fontFamily: 'Tajawal',
                                    fontSize: 13,
                                    decoration: TextDecoration.lineThrough),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'السعر/1كجم',
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                color: Color(0xff808080),
                                fontSize: 19),
                          ),
                          Container(
                            padding: const EdgeInsets.all(3.5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xff4C8613).withOpacity(.15),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.whiteColor,
                                  ),
                                  padding: const EdgeInsets.all(.1),
                                  child: GestureDetector(
                                    onTap: () {
                                      index++;
                                      context.read<CartBloc>().add(
                                          StoreToCartEvent(
                                              widget.product.id.toInt(),
                                              widget.categoryId));
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Color(0xff4C8613),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Text(
                                    index.toString(),
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.whiteColor,
                                    ),
                                    padding: const EdgeInsets.all(.1),
                                    child: const Icon(Icons.remove,
                                        color: Color(0xff4C8613)))
                              ],
                            ),
                          ),

                          /*   Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xff4C8613).withOpacity(.15),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.whiteColor,
                                  ),
                                  padding: const EdgeInsets.all(2),
                                  child: const Icon(
                                    Icons.add,
                                    color: Color(0xff4C8613),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    '0',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.whiteColor,
                                    ),
                                    padding: const EdgeInsets.all(2),
                                    child: const Icon(Icons.remove,
                                        color: Color(0xff4C8613)))
                              ],
                            ),
                          )
                     */
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Row(
                          children: [
                            CustomMainText(text: 'كود المنتج', fontSize: 17),
                            Text(
                              '56638',
                              style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  color: Color(0xff808080),
                                  fontSize: 19),
                            )
                          ],
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topRight,
                        child:
                            CustomMainText(text: 'تفاصيل المنتج', fontSize: 17),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.topRight,
                          child: Text(
                            widget.product.description,
                            style: const TextStyle(
                                fontFamily: 'Tajawal', fontSize: 14),
                          )),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomMainText(text: 'التقييمات ', fontSize: 17),
                          CustomMainText(text: 'عرض الكل ', fontSize: 15),
                        ],
                      ),
                      BlocProvider(
                        create: (context) => HomePageBloc()
                          ..add(GetProductRateEvent(widget.categoryId)),
                        child: BlocBuilder<HomePageBloc, HomePageState>(
                          builder: (context, state) {
                            return state is SuccessProductRateState
                                ? Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 80,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: state.productRates.length,
                                      itemBuilder: (c, i) {
                                        return Row(
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      state.productRates[i]
                                                          .client_name,
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontFamily: 'Tajawal',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    RatingBar(
                                                      itemSize: 18,
                                                      initialRating: state
                                                          .productRates[i].value
                                                          .toDouble(),
                                                      direction:
                                                          Axis.horizontal,
                                                      itemCount: 5,
                                                      itemPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: .01),
                                                      onRatingUpdate:
                                                          (rating) {},
                                                      ratingWidget:
                                                          RatingWidget(
                                                        full: const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        half: const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        empty: const Icon(
                                                          Icons.star,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  state.productRates[i].comment,
                                                  style: const TextStyle(
                                                      fontFamily: 'Tajawal',
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(state
                                                          .productRates[i]
                                                          .client_image)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                            ),
                                          ],
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          width: 30,
                                        );
                                      },
                                    ),
                                  )
                                : state is LoadingProductRateState
                                    ? const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: LinearProgressIndicator(),
                                      )
                                    : const Center(
                                        child: Text(
                                          'لاتوجد تقييمات',
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 16),
                                        ),
                                      );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 80.h,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
