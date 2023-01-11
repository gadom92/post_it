import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit()
      : super(
          const HomepageState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> add(String text) async {
    FirebaseFirestore.instance.collection('notes').add(
          ({
            'note': text,
          }),
        );
  }

  Future<void> delete(String id) async {
    FirebaseFirestore.instance.collection('notes').doc(id).delete();
  }

  Future<void> start() async {
    emit(const HomepageState(
      documents: [],
      errorMessage: '',
      isLoading: true,
    ));

    _streamSubscription = FirebaseFirestore.instance
        .collection('notes')
        .snapshots()
        .listen((data) {
      emit(
        HomepageState(
          documents: data.docs,
          errorMessage: '',
          isLoading: false,
        ),
      );
    })
      ..onError((error) {
        emit(
          HomepageState(
            documents: const [],
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
