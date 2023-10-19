import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_notes/app/note_book/models/notebook_models.dart';

class NoteBookRepository {
  Stream<List<NoteBookModel>> getNotebookStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notebook')
        .snapshots()
        .map(
      (querySnapshot) {
        return querySnapshot.docs.map((document) {
          return NoteBookModel(
              title: document['title'],
              text: document['text'],
              id: document.id);
        }).toList();
      },
    );
  }

  Future<void> delete({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notebook')
        .doc(id)
        .delete();
  }

  Future<void> update(String title, String text, String noteId) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notebook')
        .doc(noteId)
        .update(
      {
        'title': title,
        'text': text,
      },
    );
  }

  Future<void> addNote(String title, String text) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notebook')
        .add(
      {
        'title': title,
        'text': text,
      },
    );
  }
}
