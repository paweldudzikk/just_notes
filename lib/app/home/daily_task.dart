import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_notes/app/home/finish_task.dart';
import 'package:just_notes/app/home/task_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = TextEditingController();

  void onTaskFinished(String docId, String title) {
    FirebaseFirestore.instance.collection('FinishedTask').add(
      {'title': title},
    );

    FirebaseFirestore.instance.collection('notes').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FinishTask()),
                );
              },
              icon: const Icon(
                Icons.check_box,
                color: Colors.white,
              ))
        ],
        title: const Text(
          'DailyTask',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 161, 152, 136),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 161, 152, 136),
        onPressed: () {
          if (controller.text.trim().isEmpty) {
            return;
          }

          FirebaseFirestore.instance.collection('notes').add(
            {
              'title': controller.text,
            },
          );
          controller.clear();
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot?>(
          stream: FirebaseFirestore.instance.collection('notes').snapshots(),
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
                  Dismissible(
                    key: ValueKey(document.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: const Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          )),
                    ),
                    onDismissed: (_) {
                      FirebaseFirestore.instance
                          .collection('notes')
                          .doc(document.id)
                          .delete();
                    },
                    child: TaskWidget(
                      document['title'],
                      docId: document.id,
                      onTaskFinished: onTaskFinished,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter a new task',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
