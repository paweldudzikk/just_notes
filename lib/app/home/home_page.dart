import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_notes/app/home/task_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DailyTask',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 161, 152, 136),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
                for (final document in documents) TaskWidget(document['title']),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter a new task',
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class TaskWidget extends StatelessWidget {
  const TaskWidget(
    this.title, {
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 161, 152, 136),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      child: Text(
        title,
      ),
    );
  }
}



//  @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Color.fromARGB(255, 57, 137, 212),
//         borderRadius: BorderRadius.all(
//           Radius.circular(20),
//         ),
//       ),
//       margin: const EdgeInsets.all(10),
//       padding: const EdgeInsets.all(20),
//       child: Text(
//         title,
//       ),
//     );
//   }
// }
