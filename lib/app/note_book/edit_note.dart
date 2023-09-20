import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_notes/app/note_book/cubit/note_book_cubit.dart';

class EditNotePage extends StatelessWidget {
  final String title;
  final String text;
  final String noteId;

  const EditNotePage({
    required this.title,
    required this.text,
    required this.noteId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: title);
    final textController = TextEditingController(text: text);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Note',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 161, 152, 136),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: textController,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: 'Text',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final updatedTitle = titleController.text;
                final updatedText = textController.text;
                context
                    .read<NoteBookCubit>()
                    .update(updatedTitle, updatedText, noteId);

                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 161, 152, 136),
                ),
                minimumSize: MaterialStateProperty.all(Size(double.infinity,
                    50)), // Dostosuj szerokość i wysokość przycisku
              ),
              child: const Icon(
                Icons.change_circle_outlined,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
