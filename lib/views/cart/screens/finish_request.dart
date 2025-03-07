import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:salla_thumara/core/component/appbar.dart';
import 'package:salla_thumara/core/component/main_text.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/features/addresses/bloc.dart';
import 'package:salla_thumara/features/cart/bloc.dart';
import 'package:salla_thumara/features/google_map/bloc.dart';
import 'package:salla_thumara/features/home_page/bloc.dart';
import 'package:salla_thumara/features/login/bloc.dart';
import 'package:salla_thumara/views/address/view.dart';
import 'package:salla_thumara/views/address/widgets/addressModalSheet.dart';
import 'package:salla_thumara/views/home_page/bottom_nav_bar.dart';

class FinishRequestScreen extends StatelessWidget {
  final List<Widget> items = [
    Row(
      children: [
        SvgPicture.asset('assets/images/icons/cash.svg', color: Colors.grey),
        const SizedBox(
          width: 5,
        ),
        const Text(
          'كاش',
          style: TextStyle(fontWeight: FontWeight.w300, fontFamily: 'Tajawal'),
        )
      ],
    ),
    SvgPicture.asset('assets/images/icons/visa.svg'),
    SvgPicture.asset('assets/images/icons/matercard.svg')
  ];

  FinishRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'اتمام الطلب'),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomMainText(
                text: 'الاسم : ${LoginBloc.fullName}',
                fontSize: 17,
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomMainText(
                text: 'الجوال : ${LoginBloc.phone}',
                fontSize: 17,
              ),
              SizedBox(
                height: 18.h,
              ),
              GestureDetector(
                onTap: () {
                  navigateTo(AddAddressScreen(), withHistory: true);
                  context.read<GoogleMapBloc>().add(GoogleMapEvent());
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomMainText(
                      text: 'اختر عنوان التوصيل',
                      fontSize: 17,
                    ),
                    Icon(
                      Icons.add,
                      color: Color(0xff4C8613),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.submainColor),
                    borderRadius: BorderRadius.circular(15.r)),
                padding: EdgeInsets.all(2.r),
                child: MaterialButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${GoogleMapBloc.streatName}',
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Tajawal',
                              color: Color(0xff4C8613)),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xff4C8613),
                        )
                      ],
                    ),
                    onPressed: () async {
                      context.read<AddressesBloc>().add(GetAllAdressessEvent());
                      showModalBottomSheet(
                          context: context,
                          builder: (c) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 14),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              height: MediaQuery.of(context).size.height / 2,
                              width: double.infinity,
                              child: const AddressModalSheet(),
                            );
                          });
                    }),
              ),
              SizedBox(
                height: 16.h,
              ),
              const CustomMainText(
                text: 'تحديد وقت التوصيل',
                fontSize: 17,
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocProvider(
                    create: (context) => CartBloc(),
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            showDatePicker(
                                    cancelText: 'الغاء',
                                    confirmText: 'حسنا',
                                    helpText: 'اختيار التاريخ',
                                    fieldLabelText: 'ادخال التاريخ',
                                    errorFormatText: 'التنسيق غير صالح',
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100))
                                .then((value) {
                              context.read<CartBloc>().add(
                                  SelectDayAndDateEvent(
                                      DateFormat('yyyy-MM-dd').format(value!)));
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.submainColor),
                                borderRadius: BorderRadius.circular(20.r)),
                            padding: EdgeInsets.all(20.r),
                            child: Row(
                              children: [
                                state is SuccessSelectDayAndDateState
                                    ? Text(state.date,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Tajawal',
                                            color: Color(0xff4C8613)))
                                    : const Text(
                                        'اختر اليوم والتاريخ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Tajawal',
                                            color: Color(0xff4C8613)),
                                      ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                const Icon(Icons.access_time_filled_rounded,
                                    color: Color(0xff4C8613)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  BlocProvider(
                    create: (context) => CartBloc(),
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            showTimePicker(
                                    cancelText: 'الغاء',
                                    confirmText: 'حسنا',
                                    helpText: 'اختيار الوقت',
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((value) {
                              print(value!.minute);

                              context.read<CartBloc>().add(SelectTimeEvent(
                                  '${value.hour}:${value.minute}'));
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.submainColor),
                                borderRadius: BorderRadius.circular(20.r)),
                            padding: EdgeInsets.all(20.r),
                            child: Row(
                              children: [
                                state is SuccessSelectTimeState
                                    ? Text(state.date,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Tajawal',
                                            color: Color(0xff4C8613)))
                                    : const Text(
                                        'اختر الوقت',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Tajawal',
                                            color: Color(0xff4C8613)),
                                      ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                const Icon(Icons.date_range_outlined,
                                    color: Color(0xff4C8613)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 14.h,
              ),
              const CustomMainText(
                text: 'ملاحظات وتعليمات',
                fontSize: 17,
              ),
              SizedBox(
                height: 3.h,
              ),
              TextFormField(
                onChanged: (value) =>
                    context.read<CartBloc>().add(NoteEvent(value)),
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 14.h,
              ),
              const CustomMainText(
                text: 'اختر طريقة الدفع',
                fontSize: 17,
              ),
              SizedBox(
                height: 6.h,
              ),
              BlocProvider(
                create: (BuildContext context) => CartBloc(),
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemExtent: 100.h,
                          itemBuilder: (c, i) {
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<CartBloc>()
                                    .add(ChoosePaymentEvent(i));
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(right: 16),
                                  decoration: state is ChoosePaymentState
                                      ? BoxDecoration(
                                          color: state.index == i
                                              ? AppColors.mainColor
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        )
                                      : BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                  child: items[i]),
                            );
                          }),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              const CustomMainText(
                text: 'ملخص الطلب',
                fontSize: 17,
              ),
              SizedBox(
                height: 5.h,
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
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              BlocProvider(
                  create: (context) => CartBloc(),
                  child: BlocConsumer<CartBloc, CartState>(
                    builder: (context, state) {
                      return state is LoadingStoreOrderState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.mainColor)),
                                  onPressed: () {
                                    context
                                        .read<CartBloc>()
                                        .add(StoreOrderEvent());
                                  },
                                  child: const Text(
                                    'انهاء الطلب',
                                    style: TextStyle(color: Colors.white),
                                  )));
                    },
                    listener: (BuildContext context, CartState state) {
                      if (state is SuccessStoreOrderState) {
                        showModalBottomSheet(
                            context: context,
                            builder: (c) {
                              return const OrderModalButtonSheet();
                            });

                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     duration: const Duration(seconds: 1),
                        //     content: Text(state.data)));
                        // navigateTo(BottomNavBar());
                      } else if (state is FailStoreOrderState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 1),
                            content: Text(state.data)));
                      } else {
                        null;
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class OrderModalButtonSheet extends StatelessWidget {
  const OrderModalButtonSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/images/my_order.png'),
          const CustomMainText(
              text: 'شكرا لك لقد تم تنفيذ طلبك بنجاح', fontSize: 18),
          const Text(
            'يمكنك متابعة حالة الطلب او الرجوع للرئسيية',
            style: TextStyle(
                fontSize: 15, fontFamily: 'Tajawal', color: Color(0xffACACAC)),
          ),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.mainColor)),
                      onPressed: () {
                        context
                            .read<HomePageBloc>()
                            .add(BottomNavBarChangeEvent(1));
                        navigateTo(BottomNavBar(), withHistory: false);
                      },
                      child: const Text(
                        'طلباتي',
                        style: TextStyle(color: Colors.white),
                      ))),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<HomePageBloc>()
                            .add(BottomNavBarChangeEvent(0));
                        navigateTo(BottomNavBar(), withHistory: false);
                      },
                      child: const Text('الرئيسية'))),
            ],
          )
        ],
      ),
    );
  }
}
