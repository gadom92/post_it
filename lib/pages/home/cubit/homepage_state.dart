part of 'homepage_cubit.dart';

@immutable
class HomepageState {
  const HomepageState({
    required this.documents,
    required this.errorMessage,
    required this.isLoading,
  });

  final List<QueryDocumentSnapshot<Object?>> documents;
  final String errorMessage;
  final bool isLoading;
}
