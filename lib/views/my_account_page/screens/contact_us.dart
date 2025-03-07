import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_thumara/core/component/appbar.dart';
import 'package:salla_thumara/core/component/main_text.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/utilities/constatnt.dart';
import 'package:salla_thumara/features/account/bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<AccountBloc>();

    return Scaffold(
      appBar: const CustomAppBar(title: 'تواصل معنا'),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  launchUrlString('https://maps.app.goo.gl/yVCKFjKVS21efMmN6');
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/map.png',
                              ),
                              fit: BoxFit.fill),
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(bottom: 35.h),
                      height: height(context) / 4.h,
                      width: width(context),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      height: 100.h,
                      width: width(context) / 1.5.w,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: AppColors.mainColor,
                                size: 20,
                              ),
                              const Text(
                                'mansoura-egypt',
                                style: TextStyle(
                                    color: Color(0xff091022), fontSize: 12),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone_in_talk_rounded,
                                color: AppColors.mainColor,
                                size: 20,
                              ),
                              const Text(
                                '01029673915',
                                style: TextStyle(
                                    color: Color(0xff091022), fontSize: 12),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.mail_rounded,
                                color: AppColors.mainColor,
                                size: 20,
                              ),
                              const Text(
                                'waleedse3fan@gmail.com',
                                style: TextStyle(
                                    color: Color(0xff091022), fontSize: 12),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              const CustomMainText(text: 'أو يمكنك إرسال رسالة ', fontSize: 13),
              SizedBox(
                height: 15.h,
              ),
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
      ),
    );
  }
}
