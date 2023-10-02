import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_notes/app/daily_task/models/item_model.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemsStream() {
    return FirebaseFirestore.instance
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
    return FirebaseFirestore.instance.collection('notes').doc(id).delete();
  }

  Future<void> addTask(String title) async {
    {
      await FirebaseFirestore.instance.collection('notes').add(
        {
          'title': title,
        },
      );
    }
  }

  Future<void> addToFinishedTask(String title) async {
    {
      await FirebaseFirestore.instance.collection('FinishedTask').add(
        {'title': title},
      );
    }
  }

  Future<void> removeFromNotes(String docId) {
    {
      return FirebaseFirestore.instance.collection('notes').doc(docId).delete();
    }
  }
}
