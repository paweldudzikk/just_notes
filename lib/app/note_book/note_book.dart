import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_notes/app/note_book/cubit/add_note.dart';
import 'package:just_notes/app/note_book/cubit/note_book_cubit.dart';
import 'package:just_notes/app/note_book/notebook_widget.dart';

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
      body: BlocProvider(
          create: (context) => NoteBookCubit()..start(),
          child: BlocBuilder<NoteBookCubit, NoteBookState>(
              builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return Text(
                  'An unexpected error occurred: ${state.errorMessage}');
            }

            if (state.isLoading) {
              return const Text('Please wait while loading data');
            }

            final documents = state.documents;

            return GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 1,
              children: [
                for (final document in documents) ...[
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
                        ),
                      ),
                    ),
                    onDismissed: (_) => context
                        .read<NoteBookCubit>()
                        .remove(documentID: document.id),
                    child: NoteBookWidget(
                      document['title'],
                      document['text'],
                      document.id,
                    ),
                  ),
                ],
              ],
            );
          })),
    );
  }
}
