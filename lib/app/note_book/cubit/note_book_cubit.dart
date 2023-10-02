import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutter/foundation.dart';
import 'package:just_notes/app/note_book/models/notebook_models.dart';
import 'package:just_notes/app/repositories/note_book_repository.dart';

part 'note_book_state.dart';

class NoteBookCubit extends Cubit<NoteBookState> {
  NoteBookCubit(this._noteBookRepository)
      : super(
          const NoteBookState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _streamSubscription;
  final NoteBookRepository _noteBookRepository;

  Future<void> addNote(String title, String text) async {
    try {
      await _noteBookRepository.addNote(title, text);
      emit(const NoteBookState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ));
    } catch (error) {
      emit(const NoteBookState(
        documents: [],
        isLoading: false,
        errorMessage: 'error',
      ));
    }
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _noteBookRepository.delete(id: documentID);
    } catch (error) {
      emit(const NoteBookState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ));
      start();
    }
  }

  Future<void> update(String title, String text, String noteId) async {
    try {
      await _noteBookRepository.update(title, text, noteId);
    } catch (error) {
      emit(NoteBookState(
        documents: const [],
        isLoading: false,
        errorMessage: error.toString(),
      ));
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

    _streamSubscription =
        _noteBookRepository.getNotebookStream().listen((data) {
      emit(
        NoteBookState(
          documents: data,
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
