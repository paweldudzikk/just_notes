import 'package:flutter/material.dart';
import 'package:just_notes/app/note_book/edit_nota.dart';

class NoteBookWidget extends StatelessWidget {
  final String title;
  final String text;
  final String noteId; // Dodaj to pole

  const NoteBookWidget(
    this.title,
    this.text,
    this.noteId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditNotePage(noteId: noteId)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 161, 152, 136),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 247, 240, 240),
                  ),
                ),
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
      ),
    );
  }
}
