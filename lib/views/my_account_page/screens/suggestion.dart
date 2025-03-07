import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/core/component/appbar.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/features/account/bloc.dart';

class ComplaintsAndSuggestionScreen extends StatelessWidget {
  const ComplaintsAndSuggestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<AccountBloc>();

    return Scaffold(
      appBar: const CustomAppBar(title: 'الاقتراحات والشكاوي'),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextFormField(
              controller: bloc.suggestionNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'الاسم'),
            ),
            SizedBox(
              height: 8.h,
            ),
            TextFormField(
              controller: bloc.suggestionPhoneController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'رقم الموبايل'),
            ),
            SizedBox(
              height: 8.h,
            ),
            TextFormField(
              controller: bloc.suggestionContentontroller,
              maxLines: 3,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'الموضوع'),
            ),
            SizedBox(
              height: 8.h,
            ),
            BlocConsumer<AccountBloc, AccountState>(
              builder: (context, state) {
                return SizedBox(
                    height: 40.h,
                    width: double.infinity,
                    child: state is LoadingComplaintsAndSuggestionState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.mainColor)),
                            onPressed: () {
                              context.read<AccountBloc>().add(
                                  ComplaintsAndSuggestionEvent(
                                      bloc.suggestionNameController.text,
                                      bloc.suggestionPhoneController.text,
                                      bloc.suggestionContentontroller.text));
                            },
                            child: const Text(
                              'ارسال',
                              style: TextStyle(color: Colors.white),
                            )));
              },
              listener: (BuildContext context, AccountState state) {
                state is SuccessComplaintsAndSuggestionState
                    ? ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)))
                    : state is FailComplaintsAndSuggestionState
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)))
                        : null;
              },
            )
          ],
        ),
      ),
    );
  }
}
