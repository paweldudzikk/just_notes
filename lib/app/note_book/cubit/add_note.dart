import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_notes/app/note_book/note_book.dart';

class AddNote extends StatelessWidget {
  AddNote({Key? key}) : super(key: key);

  final titleController = TextEditingController();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 161, 152, 136),
        title: const Text(
          'Add new notes',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
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
          const SizedBox(height: 16.0), // Odstęp pomiędzy polami
          TextField(
            controller: textController,
            maxLines:
                null, // Ustawienie na null umożliwia dynamiczny rozwój liczby wierszy.
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
          const SizedBox(height: 16.0), // Odstęp pomiędzy polami
          ElevatedButton(
            onPressed: () {
              final title = titleController.text;
              final text = textController.text;

         
              if (title.isNotEmpty && text.isNotEmpty) {
                FirebaseFirestore.instance.collection('notebook').add({
                  'title': title,
                  'text': text,
                });

                titleController.clear();
                textController.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Notebook(),
                  ),
                );
              }
          
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 161, 152, 136),
              ),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
