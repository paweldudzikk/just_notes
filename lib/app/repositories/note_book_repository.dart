import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_notes/app/note_book/models/notebook_models.dart';

class NoteBookRepository {
  Stream<List<NoteBookModel>> getNotebookStream() {
    return FirebaseFirestore.instance.collection('notebook').snapshots().map(
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
    await FirebaseFirestore.instance.collection('notebook').doc(id).delete();
  }

  Future<void> update(String title, String text, String noteId) async {
    await FirebaseFirestore.instance.collection('notebook').doc(noteId).update(
      {
        'title': title,
        'text': text,
      },
    );
  }

  Future<void> addNote(String title, String text) async {
    await FirebaseFirestore.instance.collection('notebook').add(
      {
        'title': title,
        'text': text,
      },
    );
  }
}
