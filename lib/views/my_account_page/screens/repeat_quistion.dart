import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_thumara/core/component/appbar.dart';
import 'package:salla_thumara/core/utilities/constatnt.dart';
import 'package:salla_thumara/features/account/bloc.dart';

class RepeatQuistionScreen extends StatefulWidget {
  const RepeatQuistionScreen({super.key});

  @override
  State<RepeatQuistionScreen> createState() => _RepeatQuistionScreenState();
}

class _RepeatQuistionScreenState extends State<RepeatQuistionScreen> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'اسئلة متكررة'),
      body: BlocProvider(
        create: (context) => AccountBloc()..add(GetFreqQuistionEvent()),
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (BuildContext context, state) {
            return state is SuccessGetFreqQuistionState
                ? Container(
                    padding: const EdgeInsets.all(12),
                    height: height(context),
                    child: ListView.builder(
                        itemCount: state.freqQuisList.length,
                        itemBuilder: (c, i) => Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.freqQuisList[i].quistion,
                                      style: const TextStyle(
                                          color: Color(0xff4C8613),
                                          fontFamily: 'Tajawal',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          check = !check;
                                          setState(() {});
                                        },
                                        icon: Icon(!check
                                            ? Icons.arrow_circle_right_outlined
                                            : Icons.arrow_circle_down_outlined))
                                  ],
                                ),
                                BlocBuilder<AccountBloc, AccountState>(
                                  builder: (BuildContext context,
                                      AccountState statee) {
                                    return Visibility(
                                        visible: check,
                                        child: Text(
                                          state.freqQuisList[i].answer,
                                          style: const TextStyle(
                                              color: Color(0xff828282),
                                              fontFamily: 'Tajawal',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ));
                                  },
                                )
                              ],
                            )))
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
