import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/core/component/appbar.dart';
import 'package:salla_thumara/core/component/main_text.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/constatnt.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/data/order.dart';
import 'package:salla_thumara/features/cart/bloc.dart';
import 'package:salla_thumara/features/order/bloc.dart';
import 'package:salla_thumara/views/home_page/bottom_nav_bar.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const CustomMainText(text: 'طلباتي', fontSize: 20),
            centerTitle: true,
            automaticallyImplyLeading: false,
            elevation: 0,
            bottom: TabBar(
                padding: const EdgeInsets.all(10),
                labelColor: Colors.white,
                dividerColor: Colors.white,
                unselectedLabelColor: const Color(0xffA2A1A4),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                tabs: const [
                  Text(
                    'الحالية',
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'المنتهية',
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
          body: const TabBarView(children: [
            Center(
              child: CurrentOrder(),
            ),
            Center(
              child: FinishedOrder(),
            )
          ])),
    );
  }
}

class CurrentOrder extends StatelessWidget {
  const CurrentOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        child: BlocProvider(
          create: (context) => OrderBloc()..add(GetCurrentOrderEvent()),
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              return state is SuccessGetCurrentOrderState
                  ? ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (c, i) {
                        return GestureDetector(
                          onTap: () {
                            navigateTo(
                                OrderDetails(order: state.orders, index: i),
                                withHistory: true);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomMainText(
                                    text: 'طلب #${state.orders[i].id}',
                                    fontSize: 17,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffEAFFD5)
                                            .withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: CustomMainText(
                                          text: state.orders[i].status,
                                          fontSize: 11))
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                state.orders[i].datee,
                                style: const TextStyle(
                                    color: Color(0xff9C9C9C),
                                    fontFamily: 'Tajawal',
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 23.h,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                state.orders[i].products.length,
                                            itemBuilder: (c, index) {
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    right: 5),
                                                height: 22.h,
                                                width: 22.w,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  imageUrl: state.orders[i]
                                                      .products[index].url,
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                  CustomMainText(
                                      text: '${state.orders[i].order_price}ر.س',
                                      fontSize: 15)
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      })
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ));
  }
}

class FinishedOrder extends StatelessWidget {
  const FinishedOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        child: BlocProvider(
          create: (context) => OrderBloc()..add(GetFinishedOrderEvent()),
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              return state is SuccessGetFinishedOrderState
                  ? ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (c, i) {
                        return GestureDetector(
                          onTap: () {
                            navigateTo(
                                OrderDetails(order: state.orders, index: i),
                                withHistory: true);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomMainText(
                                    text: 'طلب #${state.orders[i].id}',
                                    fontSize: 17,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffFFE1E1)
                                            .withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        state.orders[i].status,
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Tajawal',
                                            color: Colors.red),
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                state.orders[i].datee,
                                style: const TextStyle(
                                    color: Color(0xff9C9C9C),
                                    fontFamily: 'Tajawal',
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 23.h,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                state.orders[i].products.length,
                                            itemBuilder: (c, index) {
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    right: 5),
                                                height: 22.h,
                                                width: 22.w,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  imageUrl: state.orders[i]
                                                      .products[index].url,
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                  CustomMainText(
                                      text: '${state.orders[i].order_price}ر.س',
                                      fontSize: 15)
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      })
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ));
  }
}

class OrderDetails extends StatelessWidget {
  final List<OrderModel> order;
  final int index;
  const OrderDetails({super.key, required this.order, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.all(15),
        width: width(context),
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xffFFE1E1))),
            onPressed: () {},
            child: const Text(
              'الغاءالطلب',
              style: TextStyle(
                  color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
            )),
      ),
    */
      appBar: const CustomAppBar(title: 'تفاصيل الطلب'),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomMainText(
                  text: 'طلب #${order[index].id}',
                  fontSize: 17,
                ),
                order[index].status == 'canceled'
                    ? Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xffFFE1E1).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          order[index].status,
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Tajawal',
                              color: Colors.red),
                        ))
                    : Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xffEAFFD5).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CustomMainText(
                            text: order[index].status, fontSize: 11))
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              order[index].datee,
              style: const TextStyle(
                  color: Color(0xff9C9C9C),
                  fontFamily: 'Tajawal',
                  fontSize: 14),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 23.h,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: order[index].products.length,
                          itemBuilder: (c, ind) {
                            return Container(
                              margin: const EdgeInsets.only(right: 5),
                              height: 22.h,
                              width: 22.w,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: order[index].products[ind].url,
                              ),
                            );
                          }),
                    )
                  ],
                ),
                CustomMainText(
                    text: '${order[index].order_price}ر.س', fontSize: 15)
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            const CustomMainText(text: 'عنوان التوصيل', fontSize: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المنزل',
                      style: TextStyle(
                          fontSize: 19,
                          fontFamily: 'Tajawal',
                          color: AppColors.mainColor),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      order[index].location.toString(),
                      style:
                          const TextStyle(fontFamily: 'Tajawal', fontSize: 13),
                    )
                  ],
                ),
                Center(
                    child: Container(
                  height: 90.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/map.png'))),
                ))
              ],
            ),
            const CustomMainText(text: 'ملخص الطلب', fontSize: 17),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: AppColors.lightmainColor2.withOpacity(.12),
                  borderRadius: BorderRadius.circular(18)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'اجمالي المنتجات',
                        style: TextStyle(
                            color: Color(0xff4C8613),
                            fontSize: 15,
                            fontFamily: 'Tajawal'),
                      ),
                      Text(
                        '${CartBloc.cartInfo!.total_price_before_discount}ر.س',
                        style: const TextStyle(
                            color: Color(0xff4C8613),
                            fontSize: 15,
                            fontFamily: 'Tajawal'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'الخصم',
                        style: TextStyle(
                            color: Color(0xff4C8613),
                            fontSize: 15,
                            fontFamily: 'Tajawal'),
                      ),
                      Text(
                        '${CartBloc.cartInfo!.total_discount}ر.س',
                        style: const TextStyle(
                            color: Color(0xff4C8613),
                            fontSize: 15,
                            fontFamily: 'Tajawal'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'المجموع',
                        style: TextStyle(
                            color: Color(0xff4C8613),
                            fontSize: 15,
                            fontFamily: 'Tajawal'),
                      ),
                      Text(
                        '${CartBloc.cartInfo!.total_price_with_vat}ر.س',
                        style: const TextStyle(
                            color: Color(0xff4C8613),
                            fontSize: 15,
                            fontFamily: 'Tajawal'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width(context) / 5,
                      ),
                      const Text(
                        'تم الدفع بواسطة',
                        style: TextStyle(
                            color: Color(0xff4C8613),
                            fontSize: 15,
                            fontFamily: 'Tajawal'),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Image.asset('assets/images/visa_notif.png')
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            BlocProvider(
              create: (context) => OrderBloc(),
              child: BlocConsumer<OrderBloc, OrderState>(
                listener: (context, state) {
                  if (state is SuccessCancelOrderState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                    navigateTo(BottomNavBar(), withHistory: false);
                  }
                },
                builder: (context, state) {
                  return state is LoadingCancelOrderState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : order[index].status == 'canceled'
                          ? SizedBox(
                              width: width(context),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.mainColor)),
                                  onPressed: () {},
                                  child: Text(
                                    'تقييم المنتجات',
                                    style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                            )
                          : SizedBox(
                              width: width(context),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xffFFE1E1))),
                                  onPressed: () {
                                    context.read<OrderBloc>().add(
                                        CancelOrderEvent(
                                            order[index].id.toInt()));
                                  },
                                  child: const Text(
                                    'الغاءالطلب',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
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
