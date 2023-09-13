import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNotePage extends StatelessWidget {
  final String noteId;

  EditNotePage({required this.noteId, Key? key}) : super(key: key);

  final titleController = TextEditingController();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final docRef =
        FirebaseFirestore.instance.collection('notebook').doc(noteId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 161, 152, 136),
        title: const Text(
          'Edit Note',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: docRef.snapshots(),
        builder: (context, snapshot) {
          final data = snapshot.data?.data() as Map<String, dynamic>?;

          if (data != null &&
              (titleController.text.isEmpty && textController.text.isEmpty)) {
            titleController.text = data['title'];
            textController.text = data['text'];
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'title',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: textController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: 'text',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final title = titleController.text;
                    final text = textController.text;

                    FirebaseFirestore.instance
                        .collection('notebook')
                        .doc(noteId)
                        .update({
                      'title': title,
                      'text': text,
                    });

                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 161, 152, 136),
                    ),
                  ),
                  child: const Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
