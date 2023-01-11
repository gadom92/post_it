import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()
      : super(
          const LoginState(
            user: null,
            errorMessage: '',
            isLoading: true,
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> signIn() async {
    FirebaseAuth.instance.signInAnonymously();
  }

  Future<void> start() async {
    emit(
      const LoginState(
        user: null,
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) {
      emit(
        LoginState(user: user, isLoading: false, errorMessage: ''),
      );
    })
          ..onError((error) {
            LoginState(
              user: null,
              isLoading: false,
              errorMessage: error.toString(),
            );
          });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
