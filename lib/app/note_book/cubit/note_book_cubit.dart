import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:just_notes/app/note_book/models/notebook_models.dart';

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

  Future<void> addNote(String title, String text) async {
    try {
      await FirebaseFirestore.instance.collection('notebook').add({
        'title': title,
        'text': text,
      });
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

  Future<void> update(String title, String text, String noteId) async {
    try {
      await FirebaseFirestore.instance
          .collection('notebook')
          .doc(noteId)
          .update({
        'title': title,
        'text': text,
      });
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

    _streamSubscription = FirebaseFirestore.instance
        .collection('notebook')
        .snapshots()
        .listen((data) {
      final notebookModel = data.docs.map((document) {
        return NoteBookModel(
            title: document['title'], text: document['text'], id: document.id);
      }).toList();
      emit(
        NoteBookState(
          documents: notebookModel,
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
