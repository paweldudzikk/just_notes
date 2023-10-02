import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:just_notes/app/repositories/finish_task_repository.dart';

import 'finished_task_state.dart';

class FinishedTaskCubit extends Cubit<FinishedTaskState> {
  FinishedTaskCubit(this._finishedTaskRepository)
      : super(
          const FinishedTaskState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  final FinishedTaskRepository _finishedTaskRepository;
  StreamSubscription? _streamSubscription;




  Future<void> start() async {
    emit(
      const FinishedTaskState(
        documents: [],
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription =
        _finishedTaskRepository.getfinishTaskStream().listen((data) {
      emit(
        FinishedTaskState(
          documents: data,
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
