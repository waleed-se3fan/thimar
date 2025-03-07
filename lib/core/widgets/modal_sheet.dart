import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/features/register/bloc.dart';

Widget modalButtomSheet(context) {
  return BlocProvider.value(
      value: BlocProvider.of<RegisterBloc>(context),
      child: BlocConsumer<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                height: 300.h,
                child: Column(
                  children: [
                    const Text(
                      'اختار مدينتك',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    //     state is CitySelectorState ? Text('yes') : Text('data'),
                    const Divider(),
                    SizedBox(
                      height: 15.h,
                    ),
                    state is ChoiseCountryLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : state is ChoiseCountrySuccessState
                            ? ListView.separated(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.cities!.length,
                                itemBuilder: (c, i) {
                                  return InkWell(
                                    onTap: () {
                                      RegisterBloc.cityValue =
                                          state.cities![i].name;
                                      RegisterBloc.cityId = state.cities![i].id;
                                      Navigator.pop(
                                          context, RegisterBloc.cityValue);

                                      context
                                          .read<RegisterBloc>()
                                          .add(CitySelectorEvent());
                                    },
                                    child: Text(
                                      state.cities![i].name,
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider();
                                },
                              )
                            : state is ChoiseCountryFailState
                                ? const Center(
                                    child: Text('fail'),
                                  )
                                : const FlutterLogo()
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {}));
}
