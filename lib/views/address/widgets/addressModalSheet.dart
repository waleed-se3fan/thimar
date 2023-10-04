import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salla_thumara/core/component/main_text.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/features/addresses/bloc.dart';
import 'package:salla_thumara/features/google_map/bloc.dart';
import 'package:salla_thumara/views/address/edit_address.dart';
import 'package:salla_thumara/views/address/view.dart';

class AddressModalSheet extends StatelessWidget {
  const AddressModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomMainText(text: 'العناوين', fontSize: 15),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.8,
            child: BlocConsumer<AddressesBloc, AddressesState>(
              listener: (context, state) {},
              builder: (context, state) {
                state is AddressesInitial
                    ? context.read<AddressesBloc>().add(GetAllAdressessEvent())
                    : null;
                return state is EmptyAddressesState
                    ? const Center(
                        child: Text('Empty list'),
                      )
                    : state is LoadingGetAllAddressesState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : state is FailGetAllAddressesState
                            ? const Center(
                                child: Text('Fail'),
                              )
                            : AddressesBloc.myAddresses!.isEmpty
                                ? const Center(
                                    child: Text('Empty list'),
                                  )
                                : ListView.builder(
                                    itemCount:
                                        AddressesBloc.myAddresses!.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                            height: 100.h,
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: const Color(
                                                        0xff4C8613))),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomMainText(
                                                        text: AddressesBloc
                                                            .myAddresses![index]
                                                            .type
                                                            .toString(),
                                                        fontSize: 15),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            context
                                                                .read<
                                                                    AddressesBloc>()
                                                                .add(
                                                                    DeleteAddressEvent(
                                                                        index));
                                                          },
                                                          child: state
                                                                      is LoadingDeleteAddress &&
                                                                  AddressesBloc
                                                                          .index ==
                                                                      index
                                                              ? const SizedBox(
                                                                  height: 18,
                                                                  width: 18,
                                                                  child:
                                                                      CircularProgressIndicator())
                                                              : SvgPicture.asset(
                                                                  'assets/images/delete.svg'),
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            navigateTo(
                                                                EditAddressScreen(
                                                                  index: index,
                                                                  allAdresses:
                                                                      AddressesBloc
                                                                          .myAddresses,
                                                                ),
                                                                withHistory:
                                                                    true);
                                                            // context
                                                            //     .read<
                                                            //         AddressesBloc>()
                                                            //     .add(event);
                                                            context
                                                                .read<
                                                                    GoogleMapBloc>()
                                                                .add(
                                                                    GoogleMapEvent());
                                                          },
                                                          child: SvgPicture.asset(
                                                              'assets/images/edit.svg'),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  'العنوان: ${AddressesBloc.myAddresses![index].location}',
                                                  style: const TextStyle(
                                                      color: Color(0xff4C8613),
                                                      fontSize: 14,
                                                      fontFamily: 'Tajawal'),
                                                ),
                                                Text(
                                                  'الوصف: ${AddressesBloc.myAddresses![index].description}',
                                                  style: const TextStyle(
                                                      fontFamily: 'Tajawal',
                                                      color: Color(0xff999797),
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  'رقم الجوال: ${AddressesBloc.myAddresses![index].phone}',
                                                  style: const TextStyle(
                                                      fontFamily: 'Tajawal',
                                                      color: Color(0xff999797),
                                                      fontSize: 14),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      );
                                    });
              },
            ),
          ),
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(18),
            child: SizedBox(
              width: double.infinity,
              height: 35.h,
              child: ElevatedButton(
                onPressed: () {
                  navigateTo(AddAddressScreen(), withHistory: true);
                  context.read<GoogleMapBloc>().add(GoogleMapEvent());
                },
                child: const Text('اضافة عنوان جديد'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
