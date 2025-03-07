import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_thumara/core/component/appbar.dart';
import 'package:salla_thumara/features/account/bloc.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'سياسة الخصوصية'),
        body: BlocProvider(
            create: (context) => AccountBloc()..add(GetPolicyEvent()),
            child: BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                return state is SuccessPolicyState
                    ? Text(state.policy)
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              },
            )));
  }
}
