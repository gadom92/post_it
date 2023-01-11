part of 'homepage_cubit.dart';

class HomepageState {
  const HomepageState({
this.items = const [],
    required this.errorMessage,
    required this.isLoading,
  });

  final List<ItemModel> items;
  final String errorMessage;
  final bool isLoading;
}
