import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_notes/app/models/finished_task_model.dart';

class FinishedTaskRepository {
  Stream<List<FinishedTaskModel>> getfinishTaskStream() {
    return FirebaseFirestore.instance
        .collection('FinishedTask')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((document) {
        return FinishedTaskModel(
          title: document['title'],
          id: document.id,
        );
      }).toList();
    });
  }


}
