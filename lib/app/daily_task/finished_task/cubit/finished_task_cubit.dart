import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:just_notes/app/models/finished_task_model.dart';

import 'finished_task_state.dart';

class FinishedTaskCubit extends Cubit<FinishedTaskState> {
  FinishedTaskCubit()
      : super(
          const FinishedTaskState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const FinishedTaskState(
        documents: [],
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('FinishedTask')
        .snapshots()
        .listen((data) {
      final finishedTaskModels = data.docs.map((document) {
        return FinishedTaskModel(
          title: document['title'],
          id: document.id,
        );
      }).toList();
      emit(
        FinishedTaskState(
          documents: finishedTaskModels,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          FinishedTaskState(
            documents: const [],
            isLoading: false,
            errorMessage: error.toString(),
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
