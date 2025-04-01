import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salla_thumara/core/component/appbar.dart';
import 'package:salla_thumara/core/component/main_text.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/features/google_map/bloc.dart';
import 'package:salla_thumara/views/home_page/bottom_nav_bar.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddAddressScreen extends StatelessWidget {
  final bloc = GoogleMapBloc();

  AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'اضافة العنوان'),
        body: SingleChildScrollView(
            child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.6,
                  child: BlocProvider(
                    create: (context) =>
                        GoogleMapBloc()..add(GetGoogleMapEvent()),
                    child: BlocConsumer<GoogleMapBloc, GoogleMapState>(
                      builder: (context, state) {
                        if (state is SuccessGoogleMapState) {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: GoogleMap(
                                  key: const ValueKey('map'),
                                  liteModeEnabled: true,
                                  onTap: (value) {
                                    context.read<GoogleMapBloc>().add(
                                        GetLocationEvent(
                                            value.latitude, value.longitude));
                                  },
                                  markers: {
                                    Marker(
                                        markerId: const MarkerId('location'),
                                        position:
                                            LatLng(state.latit, state.long))
                                  },
                                  initialCameraPosition: CameraPosition(
                                      zoom: 12,
                                      target:
                                          LatLng(state.latit, state.long))));
                        } else if (state is SuccessGetLocation) {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: GoogleMap(
                                  key: const ValueKey('map'),
                                  liteModeEnabled: true,
                                  onTap: (value) {
                                    context.read<GoogleMapBloc>().add(
                                        GetLocationEvent(
                                            value.latitude, value.longitude));
                                  },
                                  markers: {
                                    Marker(
                                        markerId: const MarkerId('location'),
                                        position: LatLng(state.lat, state.long))
                                  },
                                  initialCameraPosition: CameraPosition(
                                      zoom: 12,
                                      target: LatLng(state.lat, state.long))));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                      listener: (BuildContext context, GoogleMapState state) {},
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'نوع المنزل',
                        style: TextStyle(
                            color: Color(0xff8B8B8B),
                            fontSize: 15,
                            fontFamily: 'Tajawal'),
                      ),
                      ToggleSwitch(
                          inactiveBgColor: const Color(0xffE9E9E9),
                          borderColor: const [Colors.white],
                          initialLabelIndex: 0,
                          totalSwitches: 2,
                          labels: const ['المنزل', 'العمل'],
                          onToggle: (value) => context
                              .read<GoogleMapBloc>()
                              .add(ChangeTypeEvent(
                                  value == 0 ? 'المنزل' : 'العمل'))),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: bloc.phoneController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'ادخل رقم الجوال',
                    hintStyle: TextStyle(
                        color: Color(0xff8B8B8B),
                        fontSize: 15,
                        fontFamily: 'Tajawal'),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: bloc.descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'الوصف',
                    hintStyle: TextStyle(
                        color: Color(0xff8B8B8B),
                        fontSize: 15,
                        fontFamily: 'Tajawal'),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    BlocProvider(
                      create: (context) => GoogleMapBloc(),
                      child: BlocBuilder<GoogleMapBloc, GoogleMapState>(
                        builder: (context, statee) {
                          return statee is SuccessChangeMainAddressState
                              ? Checkbox(
                                  value: statee.check,
                                  onChanged: (value) => context
                                      .read<GoogleMapBloc>()
                                      .add(ChangeMainAddressEvent(value!)),
                                )
                              : Checkbox(
                                  value: bloc.mainAddress,
                                  onChanged: (value) => context
                                      .read<GoogleMapBloc>()
                                      .add(ChangeMainAddressEvent(value!)),
                                );
                        },
                      ),
                    ),
                    const CustomMainText(
                        text: 'التعيين كعنوان رئيسي', fontSize: 14)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocConsumer<GoogleMapBloc, GoogleMapState>(
                  builder: (context, state) {
                    if (state is LoadingAddnewLocationState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(18),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.mainColor)),
                            onPressed: () async {
                              context.read<GoogleMapBloc>().add(
                                  AddNewLocationEvent(
                                      GoogleMapBloc.type,
                                      bloc.phoneController.text,
                                      bloc.descriptionController.text,
                                      GoogleMapBloc.latit!,
                                      GoogleMapBloc.long!,
                                      GoogleMapBloc.streatName!,
                                      bloc.mainAddress));
                            },
                            child: const Text(
                              'اضافة العنوان',
                              style: TextStyle(color: Colors.white),
                            )),
                      );
                    }
                  },
                  listener: (BuildContext context, GoogleMapState state) {
                    if (state is SuccessAddnewLocationState) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                      navigateTo(BottomNavBar(), withHistory: false);
                    } else if (state is FailAddnewLocationState) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                ),
              ],
            ),
          ),
        )));
  }
}
