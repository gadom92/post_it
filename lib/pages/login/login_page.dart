import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_it/pages/login/cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/images/background.jpg',
            ),
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(100),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/post.jpg',
                ),
              ),
            ),
            child: Center(
              child: TextButton(
                onPressed: () async {
                  context.read<LoginCubit>().signIn();
                },
                child: const AutoSizeText(
                  maxLines: 3,
                  'Otwórz swoją tablicę',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 72,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
