import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salla_thumara/core/component/main_text.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/navigation.dart';
import 'package:salla_thumara/data/addresses.dart';
import 'package:salla_thumara/features/google_map/bloc.dart';
import 'package:salla_thumara/views/home_page/bottom_nav_bar.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EditAddressScreen extends StatefulWidget {
  final List<Addresses>? allAdresses;
  final int index;
  const EditAddressScreen(
      {super.key, required this.index, required this.allAdresses});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late final TextEditingController phoneController;
  late final TextEditingController descriptionController;
  @override
  void initState() {
    phoneController =
        TextEditingController(text: widget.allAdresses![widget.index].phone);
    descriptionController = TextEditingController(
        text: widget.allAdresses![widget.index].description);
    super.initState();
    GoogleMapBloc().editDescriptionController =
        widget.allAdresses![widget.index].description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: BlocConsumer<GoogleMapBloc, GoogleMapState>(
        listener: (context, state) {},
        builder: (context, state) {
          var bloc = context.read<GoogleMapBloc>();

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(68, 76, 134, 19),
                              borderRadius: BorderRadius.circular(18)),
                          child: IconButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back_ios_rounded))),
                      const Expanded(
                        child: Center(
                          child: CustomMainText(
                              text: 'تعديل العنوان', fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 2.6,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: BlocProvider(
                              create: (context) => GoogleMapBloc(),
                              child: BlocBuilder<GoogleMapBloc, GoogleMapState>(
                                builder: (context, state) {
                                  if (state is SuccessGetEditLocation) {
                                    return GoogleMap(
                                        key: const ValueKey('map'),
                                        liteModeEnabled: true,
                                        onTap: (value) {
                                          context.read<GoogleMapBloc>().add(
                                              GetEditLocationEvent(
                                                  value.latitude,
                                                  value.longitude));
                                        },
                                        markers: {
                                          Marker(
                                              markerId:
                                                  const MarkerId('location'),
                                              position:
                                                  LatLng(state.lat, state.long))
                                        },
                                        initialCameraPosition: CameraPosition(
                                            zoom: 12,
                                            target:
                                                LatLng(state.lat, state.long)));
                                  } else if (state is FailGetEditLocation) {
                                    return const Center(child: Text('Fail'));
                                  } else {
                                    return GoogleMap(
                                        key: const ValueKey('map'),
                                        liteModeEnabled: true,
                                        onTap: (value) {
                                          context.read<GoogleMapBloc>().add(
                                              GetEditLocationEvent(
                                                  value.latitude,
                                                  value.longitude));
                                        },
                                        markers: {
                                          Marker(
                                              markerId:
                                                  const MarkerId('location'),
                                              position: LatLng(
                                                  widget
                                                      .allAdresses![
                                                          widget.index]
                                                      .lat,
                                                  widget
                                                      .allAdresses![
                                                          widget.index]
                                                      .lng))
                                        },
                                        initialCameraPosition: CameraPosition(
                                            zoom: 12,
                                            target: LatLng(
                                                widget
                                                    .allAdresses![widget.index]
                                                    .lat,
                                                widget
                                                    .allAdresses![widget.index]
                                                    .lng)));
                                  }
                                },
                              )))),
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
                          initialLabelIndex:
                              widget.allAdresses![widget.index].type == 'home'
                                  ? 0
                                  : 1,
                          totalSwitches: 2,
                          labels: const ['المنزل', 'العمل'],
                          onToggle: (index) {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    // controller: bloc.editPhoneController,

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
                    controller: descriptionController,
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
                  Row(
                    children: [
                      BlocProvider(
                        create: (context) => GoogleMapBloc(),
                        child: BlocBuilder<GoogleMapBloc, GoogleMapState>(
                          builder: (context, statee) {
                            return statee is SuccessEditMainAddressState
                                ? Checkbox(
                                    value: statee.check,
                                    onChanged: (value) => context
                                        .read<GoogleMapBloc>()
                                        .add(EditMainAddressEvent(value!)),
                                  )
                                : Checkbox(
                                    value: widget.allAdresses![widget.index]
                                                .isDefault ==
                                            true
                                        ? true
                                        : bloc.editAddress,
                                    onChanged: (value) => context
                                        .read<GoogleMapBloc>()
                                        .add(EditMainAddressEvent(value!)),
                                  );
                          },
                        ),
                      ),
                      const CustomMainText(
                          text: 'التعيين كعنوان رئيسي', fontSize: 14)
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocProvider(
                      create: (context) => GoogleMapBloc(),
                      child: BlocConsumer<GoogleMapBloc, GoogleMapState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return state is LoadingEditLocationState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(18),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.mainColor)),
                                      onPressed: () async {
                                        context.read<GoogleMapBloc>().add(
                                            UpdateLocationEvent(
                                                widget
                                                    .allAdresses![widget.index]
                                                    .id,
                                                bloc.editType == 1
                                                    ? 'المنزل'
                                                    : 'العمل',
                                                descriptionController.text,
                                                phoneController.text,
                                                GoogleMapBloc.latit!,
                                                GoogleMapBloc.long!,
                                                GoogleMapBloc.streatName!,
                                                bloc.editAddress));

                                        navigateTo(BottomNavBar(),
                                            withHistory: false);
                                      },
                                      child: const Text(
                                        'تعديل العنوان',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                );
                        },
                      ))
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
