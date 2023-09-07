import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'daily_task_state.dart';

class DailyTaskCubit extends Cubit<DailyTaskState> {
  DailyTaskCubit()
      : super(const DailyTaskState(
          documents: [],
          isLoading: false,
          errorMassage: '',
        ));

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(const DailyTaskState(
      documents: [],
      isLoading: true,
      errorMassage: '',
    ));

    _streamSubscription = FirebaseFirestore.instance
        .collection('notes')
        .snapshots()
        .listen((data) {
      emit(DailyTaskState(
        documents: data.docs,
        isLoading: false,
        errorMassage: '',
      ));
    })
      ..onError((error) {
        emit(DailyTaskState(
          documents: const [],
          isLoading: false,
          errorMassage: error.toString(),
        ));
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
