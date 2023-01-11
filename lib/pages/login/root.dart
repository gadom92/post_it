import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_it/pages/login/cubit/login_cubit.dart';
import '../home/homepage.dart';
import 'login_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      final user = state.user;
      if (user == null) {
        return const LoginPage();
      }
      return HomePage();
    });
  }
}
