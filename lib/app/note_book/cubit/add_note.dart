import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_notes/app/note_book/cubit/note_book_cubit.dart';
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
          const SizedBox(height: 16.0),
          TextField(
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
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              final title = titleController.text;
              final text = textController.text;

              if (title.isNotEmpty && text.isNotEmpty) {
                context.read<NoteBookCubit>().addNote(title, text);

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
