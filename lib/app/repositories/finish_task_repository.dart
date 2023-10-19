import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_notes/app/daily_task/models/finished_task_model.dart';

class FinishedTaskRepository {
  Stream<List<FinishedTaskModel>> getfinishTaskStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
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
