import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:post_it/models/item_model.dart';
import '../../../repositories/items_repository.dart';
part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit(this._itemsRepository)
      : super(
          const HomepageState(
            items: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;

  Future<void> add(String text) async {
    await _itemsRepository.add(text: text);
  }

  Future<void> delete(String id) async {
    await _itemsRepository.delete(id: id);
  }

  Future<void> start() async {
    emit(const HomepageState(
      items: [],
      errorMessage: '',
      isLoading: true,
    ));

    _streamSubscription = _itemsRepository.getItemsStream().listen((items) {
      emit(
        HomepageState(
          items: items,
          errorMessage: '',
          isLoading: false,
        ),
      );
    })
      ..onError((error) {
        emit(
          HomepageState(
            items: const [],
            errorMessage: error.toString(),
            isLoading: false,
          ),
        );
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
