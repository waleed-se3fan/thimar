import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salla_thumara/core/component/appbar.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/constatnt.dart';
import 'package:salla_thumara/features/account/bloc.dart';
import 'package:salla_thumara/views/my_account_page/screens/paymob.dart';

class WalletSceen extends StatelessWidget {
  const WalletSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'المحفظة'),
        body: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            state is AccountInitial
                ? context.read<AccountBloc>().add(GetWalletEvent())
                : null;
            if (state is SuccessGetWalletState) {
              return ViewWidget(state: state);
            } else if (state is LoadingChargeWalletState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class ViewWidget extends StatelessWidget {
  final SuccessGetWalletState state;

  ViewWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(18.r),
        child: Column(
          children: [
            const Text(
              'رصيدك',
              style: TextStyle(
                  color: Color(0xff4C8613),
                  fontFamily: 'Tajawal',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              '${state.wallet} ر.س',
              style: const TextStyle(
                  color: Color(0xff4C8613),
                  fontFamily: 'Tajawal',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50.h,
            ),
            const MyButton(),
            SizedBox(
              height: 25.h,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 80.w))),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return Expanded(
                          child: AlertDialog(
                            title:
                                const Center(child: Text('شحن عن طريق Paymob')),
                            content: Row(
                              children: [
                                SizedBox(
                                    width: width(context) / 2,
                                    child: TextFormField(
                                      controller: AccountBloc.amountController,
                                    )),
                                const Text('جنيه')
                              ],
                            ),
                            actions: [
                              BlocProvider(
                                create: (context) => AccountBloc(),
                                child: BlocBuilder<AccountBloc, AccountState>(
                                  builder: (context, state) {
                                    return SizedBox(
                                        width: width(context) / 1.5,
                                        child: state is LoadingPaymopState
                                            ? Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 100.w),
                                                child:
                                                    const CircularProgressIndicator())
                                            : ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            AppColors
                                                                .mainColor)),
                                                onPressed: () async {
                                                  context
                                                      .read<AccountBloc>()
                                                      .add(PaymopEventEvent(
                                                          AccountBloc
                                                              .amountController
                                                              .text,
                                                          context));
                                                  AccountBloc.amountController
                                                      .clear();
                                                },
                                                child: const Text(
                                                  'تطبيق',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ));
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: const Text('اشحن عن طريق paymop')),
            SizedBox(
              height: 50.h,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'سجل المعاملات',
                  style: TextStyle(
                      color: Color(0xff4C8613),
                      fontFamily: 'Tajawal',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'عرض الكل',
                  style: TextStyle(
                      color: Color(0xff4C8613),
                      fontFamily: 'Tajawal',
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: height(context) / 2,
              child: ListView.builder(
                  itemCount: state.allWallet.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (c, i) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/images/icons/arrow_top.svg'),
                                Text(
                                  state.allWallet[i].status_trans,
                                  style: const TextStyle(
                                      color: Color(0xff4C8613),
                                      fontFamily: 'Tajawal',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              state.allWallet[i].date,
                              style: const TextStyle(
                                  color: Color(0xff9C9C9C),
                                  fontFamily: 'Tajawal',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30.w),
                          child: Text(
                            state.allWallet[i].amount.toString(),
                            style: const TextStyle(
                                color: Color(0xff4C8613),
                                fontFamily: 'Tajawal',
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        )
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc(),
      child: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {},
        builder: (context, state) {
          return DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(18),
            child: SizedBox(
              width: double.infinity,
              height: 35.h,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Expanded(
                        child: AlertDialog(
                          title: const Center(child: Text('شحن المحفظة')),
                          content: Row(
                            children: [
                              SizedBox(
                                  width: width(context) / 2,
                                  child: TextFormField(
                                    controller: AccountBloc.amountController,
                                  )),
                              const Text('ر.س')
                            ],
                          ),
                          actions: [
                            SizedBox(
                              width: width(context) / 1.5,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        AppColors.mainColor)),
                                onPressed: () {
                                  context.read<AccountBloc>().add(
                                      ChargeWalletEvent(
                                          AccountBloc.amountController.text));
                                  AccountBloc.amountController.clear();

                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'تطبيق',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );

                  // showAboutDialog(
                  //     context: context,
                  //     applicationName: 'شحن المحفظة',
                  //     children: [Text('data'), Text('data')]);
                },
                child: const Text(
                  'اشحن الان',
                  style: TextStyle(
                      color: Color(0xff4C8613),
                      fontFamily: 'Tajawal',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
