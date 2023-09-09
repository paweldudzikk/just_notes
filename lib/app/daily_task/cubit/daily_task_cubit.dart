import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_notes/app/daily_task/repositories/items_repository.dart';
import 'package:just_notes/app/models/item_model.dart';
import 'package:meta/meta.dart';

part 'daily_task_state.dart';

class DailyTaskCubit extends Cubit<DailyTaskState> {
  DailyTaskCubit(this._itemsRepository)
      : super(const DailyTaskState(
          documents: [],
          isLoading: false,
          errorMassage: '',
        ));

  final ItemsRepository _itemsRepository;
  StreamSubscription? _streamSubscription;

  Future<void> addTask(
    String title,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('notes').add(
        {
          'title': title,
        },
      );
    } catch (error) {
      emit(DailyTaskState(
        documents: state.documents,
        isLoading: true,
        errorMassage: error.toString(),
      ));
    }
  }

  Future<void> remove({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('notes')
          .doc(documentID)
          .delete();
    } catch (error) {
      emit(
        DailyTaskState(
          documents: state.documents,
          errorMassage: error.toString(),
          isLoading: true,
        ),
      );
    }
  }

  Future<void> start() async {
    emit(const DailyTaskState(
      documents: [],
      isLoading: true,
      errorMassage: '',
    ));

    _streamSubscription = _itemsRepository.getItemsStream().listen((data) {
      emit(DailyTaskState(
        documents: data,
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
