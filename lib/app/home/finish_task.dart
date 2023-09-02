import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_notes/app/home/task_widget.dart';

class FinishTask extends StatelessWidget {
  const FinishTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 161, 152, 136),
        title: const Text(
          'Finished Task',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot?>(
        stream:
            FirebaseFirestore.instance.collection('FinishedTask').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('An unexpected error occurred');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Please wait while loading data');
          }

          final documents = snapshot.data!.docs;

          return ListView(
            children: [
              for (final document in documents)
                TaskWidget(
                  document['title'],
                  docId: document.id,
                  onTaskFinished: (String docId, String title) {},
                  isStrikethrough: true,
                ),
            ],
          );
        },
      ),
    );
  }
}
