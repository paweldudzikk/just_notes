import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_notes/app/daily_task/models/item_model.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notes')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((document) {
        return ItemModel(
          title: document['title'],
          id: document.id,
        );
      }).toList();
    });
  }

  Future<void> delete({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notes')
        .doc(id)
        .delete();
  }

  Future<void> addTask(String title) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('notes')
          .add(
        {
          'title': title,
        },
      );
    }
  }

  Future<void> addToFinishedTask(String title) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('FinishedTask')
          .add(
        {'title': title},
      );
    }
  }

  Future<void> removeFromNotes(String docId) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }

    {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('notes')
          .doc(docId)
          .delete();
    }
  }
}
