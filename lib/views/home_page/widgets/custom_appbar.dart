import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salla_thumara/core/utilities/images.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/features/addresses/bloc.dart';
import 'package:salla_thumara/features/cart/bloc.dart';
import 'package:salla_thumara/views/cart/cart.dart';
import 'package:salla_thumara/views/address/widgets/addressModalSheet.dart';
import '../../../features/google_map/bloc.dart';

class Appbar extends StatelessWidget implements PreferredSize {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60.h,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(AppImaes().homeLogo),
                SizedBox(
                  width: 3.w,
                ),
                const Text(
                  'سلة ثمار',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                      fontSize: 14,
                      color: Color(0xff4C8613)),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
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
              },
              child: Column(
                children: [
                  const Text(
                    'التوصيل الي',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                        fontSize: 12,
                        color: Color(0xff4C8613)),
                  ),
                  BlocProvider(
                    create: (context) =>
                        GoogleMapBloc()..add(GetGoogleMapEvent()),
                    child: BlocConsumer<GoogleMapBloc, GoogleMapState>(
                      builder: (context, state) {
                        return state is SuccessGoogleMapState
                            ? Text(
                                state.streatName.toString(),
                                style: const TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: 14,
                                    color: Color(0xff4C8613)),
                              )
                            : const Text(
                                'عنواني',
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: 14,
                                    color: Color(0xff4C8613)),
                              );
                      },
                      listener: (context, state) {},
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                navigateTo(const CartScreen());
              },
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topRight,
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(15)),
                      child: SvgPicture.asset(AppImaes().bag)),
                  const CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.white,
                  ),
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: const Color(0xff4C8613),
                    child: BlocConsumer<CartBloc, CartState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        state is CartInitial
                            ? context.read<CartBloc>().add(GetAllCartsEvent())
                            : null;
                        return Text(
                          state is SuccessGetAllCartsState
                              ? state.carts.length.toString()
                              : CartBloc.carts == null
                                  ? '0'
                                  : CartBloc.carts!.length.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 7,
                              fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(300);
}
