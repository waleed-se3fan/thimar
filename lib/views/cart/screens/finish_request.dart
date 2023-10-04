import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salla_thumara/core/component/appbar.dart';
import 'package:salla_thumara/core/utilities/colors.dart';
import 'package:salla_thumara/core/widgets/modal_sheet.dart';
import 'package:salla_thumara/features/cart/bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
      body: ListView(
        children: [
          const Text('الاسم : وليد'),
          const Text('الجوال : 01029673915'),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('اختر عنوان التوصيل'), Icon(Icons.add)],
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.submainColor),
                borderRadius: BorderRadius.circular(15.r)),
            padding: EdgeInsets.all(2.r),
            child: MaterialButton(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المنزل: شارع الملك عبدالعزيز /السعودية ',
                      style: TextStyle(fontSize: 15, fontFamily: 'Tajawal'),
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded)
                  ],
                ),
                onPressed: () async {
                  showModalBottomSheet(
                    context: context,
                    builder: (mcontext) {
                      return modalButtomSheet(context);
                    },
                  );
                }),
          ),
          const Text('تحديد وقت التوصيل'),
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
                            .then((value) => context.read<CartBloc>().add(
                                SelectDayAndDateEvent(
                                    '${value!.year}-${value.month}-${value.day}')));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.submainColor),
                            borderRadius: BorderRadius.circular(20.r)),
                        padding: EdgeInsets.all(20.r),
                        child: Row(
                          children: [
                            state is SuccessSelectDayAndDateState
                                ? Text(state.date)
                                : const Text('اختر اليوم والتاريخ'),
                            SvgPicture.asset('assets/images/icons/day.svg')
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
                            .then((value) => context.read<CartBloc>().add(
                                SelectTimeEvent(
                                    '${value!.hour}-${value.minute}')));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.submainColor),
                            borderRadius: BorderRadius.circular(20.r)),
                        padding: EdgeInsets.all(20.r),
                        child: Row(
                          children: [
                            state is SuccessSelectTimeState
                                ? Text(state.date)
                                : const Text('اختر الوقت'),
                            const Icon(Icons.lock_clock_outlined)
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const Text('ملاحظات وتعليمات'),
          TextFormField(
            onChanged: (value) =>
                context.read<CartBloc>().add(NoteEvent(value)),
            maxLines: 4,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const Text('اختر طريقة الدفع'),
          BlocProvider(
            create: (BuildContext context) => CartBloc(),
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return Container(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemExtent: 100.h,
                      itemBuilder: (c, i) {
                        return GestureDetector(
                          onTap: () {
                            context.read<CartBloc>().add(ChoosePaymentEvent(i));
                          },
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(right: 16),
                              decoration: state is ChoosePaymentState
                                  ? BoxDecoration(
                                      color: state.index == i
                                          ? AppColors.mainColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    )
                                  : BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                              child: items[i]),
                        );
                      }),
                );
              },
            ),
          ),
          const Text('ملخص الطلب'),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.mainColor)),
                  onPressed: () {},
                  child: const Text(
                    'انهاء الطلب',
                    style: TextStyle(color: Colors.white),
                  )))
        ],
      ),
    );
  }
}
