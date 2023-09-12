import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_notes/app/note_book/cubit/add_note.dart';

class Notebook extends StatelessWidget {
  const Notebook({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 161, 152, 136),
        title: const Text(
          'Notebook',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 161, 152, 136),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('notebook').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('An unexpected error occurred');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Please wait while loading data');
            }

            final documents = snapshot.data!.docs;

            return GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 1,
              children: [
                for (final document in documents) ...[
                  NoteBookWidget(
                    document['title'],
                    document['text'],
                  ),
                ],
              ],
            );
          }),
    );
  }
}

class NoteBookWidget extends StatelessWidget {
  final String title;
  final String text;

  const NoteBookWidget(
    this.title,
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 161, 152, 136),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 247, 240, 240),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 247, 240, 240),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
