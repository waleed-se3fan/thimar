import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_thumara/core/component/appbar.dart';
import 'package:salla_thumara/features/account/bloc.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الشروط والاحكام'),
      body: BlocProvider(
        create: (BuildContext context) => AccountBloc()..add(GetTermsEvent()),
        child: BlocConsumer<AccountBloc, AccountState>(
          builder: (BuildContext context, state) {
            return state is SuccessGetTermsState
                ? Text(state.data)
                : const Center(child: CircularProgressIndicator());
          },
          listener: (BuildContext context, Object? state) {},
        ),
      ),
    );
  }
}
