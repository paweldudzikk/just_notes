import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_notes/app/models/item_model.dart';

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
}
