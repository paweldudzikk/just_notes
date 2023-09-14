import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'note_book_state.dart';

class NoteBookCubit extends Cubit<NoteBookState> {
  NoteBookCubit()
      : super(
          const NoteBookState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> remove({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('notebook')
          .doc(documentID)
          .delete();
    } catch (error) {
      emit(const NoteBookState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ));
      start();
    }
  }

  Future<void> start() async {
    emit(
      const NoteBookState(
        documents: [],
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('notebook')
        .snapshots()
        .listen((data) {
      emit(
        NoteBookState(
          documents: data.docs,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          NoteBookState(
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
