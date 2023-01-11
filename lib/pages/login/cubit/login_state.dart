part of 'login_cubit.dart';

@immutable
class LoginState {
  const LoginState({
    required this.user,
    required this.isLoading,
    required this.errorMessage,
  });

  final User? user;
  final bool isLoading;
  final String errorMessage;
}
