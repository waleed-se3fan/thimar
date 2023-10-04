import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salla_thumara/core/component/appbar.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/features/cart/bloc.dart';
import 'package:salla_thumara/views/cart/screens/finish_request.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'السلة'),
      bottomSheet: const CompleteRequest(),
      body: SafeArea(
        child: Column(
          children: [
            BlocConsumer<CartBloc, CartState>(
              listener: (BuildContext context, state) {},
              builder: (BuildContext context, state) {
                state is CartInitial
                    ? context.read<CartBloc>().add(GetAllCartsEvent())
                    : null;
                return state is FailGetAllCartsState
                    ? const Center(
                        child: Text('Fail'),
                      )
                    : SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 1.9,
                          child: CartBloc.cartInfo!.data.isEmpty
                              ? const Center(
                                  child: Text('Empty'),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: CartBloc.cartInfo!.data.length,
                                  itemBuilder: (c, i) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 110,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          CartBloc.cartInfo!
                                                              .data[i].image
                                                              .toString()))),
                                            ),
                                            Column(
                                              children: [
                                                Text(CartBloc
                                                    .cartInfo!.data[i].title
                                                    .toString()),
                                                Text(
                                                    '${CartBloc.cartInfo!.data[i].price.toString()}ر.س'),
                                                Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      child: const Icon(
                                                        Icons.add,
                                                        color:
                                                            Color(0xff4C8613),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15),
                                                      child: Text(
                                                        CartBloc.cartInfo!
                                                            .data[i].amount
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                    Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: AppColors
                                                              .whiteColor,
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        child: const Icon(
                                                            Icons.remove,
                                                            color: Color(
                                                                0xff4C8613)))
                                                  ],
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<CartBloc>()
                                                      .add(DeleteFromCart(i));
                                                },
                                                child: state
                                                            is LoadingDeleteCartState &&
                                                        CartBloc.cartIndex == i
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : SvgPicture.asset(
                                                        'assets/images/delete.svg'))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    );
                                  }),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 100,
          width: 110,
          color: Colors.amber,
        ),
        const Column(
          children: [
            Text('طماطم'),
            Text('45ر.س'),
            Row(
              children: [Icon(Icons.add), Text('5'), Icon(Icons.remove)],
            )
          ],
        ),
        const Icon(Icons.delete)
      ],
    );
  }
}

class CompleteRequest extends StatelessWidget {
  const CompleteRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height / 2.5,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'عندك كوبون ؟ ادخل رقم الكوبون',
                          hintStyle: const TextStyle(
                              fontSize: 13, fontFamily: 'Tajawal'),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.mainColor))),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.mainColor)),
                        onPressed: () {},
                        child: const Text(
                          'تطبيق',
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
              Text(
                'جميع الأسعار تشمل قيمة الضريبة المضافة 15%',
                style: TextStyle(
                    color: AppColors.mainColor,
                    fontFamily: 'Tajawal',
                    fontSize: 15),
              ),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: AppColors.lightmainColor2.withOpacity(.2),
                    borderRadius: BorderRadius.circular(18)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('اجمالي المنتجات'),
                        Text(CartBloc.cartInfo!.total_price_before_discount
                            .toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('الخصم'),
                        Text(CartBloc.cartInfo!.total_discount.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('المجموع'),
                        Text(CartBloc.cartInfo!.total_price_with_vat.toString())
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.mainColor)),
                      onPressed: () {
                        navigateTo(FinishRequestScreen(), withHistory: true);
                      },
                      child: const Text(
                        'الانتقال لاتمام الطلب',
                        style: TextStyle(color: Colors.white),
                      )))
            ],
          ),
        );
      },
    );
  }
}
