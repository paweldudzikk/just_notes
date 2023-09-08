import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_notes/app/daily_task/cubit/daily_task_cubit.dart';
import 'package:just_notes/app/daily_task/finish_task.dart';
import 'package:just_notes/app/daily_task/task_widget.dart';

class DailyTask extends StatelessWidget {
  DailyTask({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  void onTaskFinished(String docId, String title) {
    FirebaseFirestore.instance.collection('FinishedTask').add(
      {'title': title},
    );

    FirebaseFirestore.instance.collection('notes').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DailyTaskCubit()..start(),
      child: BlocBuilder<DailyTaskCubit, DailyTaskState>(
        builder: (context, state) {
          if (state.errorMassage.isNotEmpty) {
            return Text('An unexpected error occurred: ${state.errorMassage}');
          }

          if (state.isLoading) {
            return const Text('Please wait while loading data');
          }

          final documents = state.documents;

          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FinishTask(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_box, color: Colors.white),
                ),
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
                context.read<DailyTaskCubit>().addTask(controller.text);
                controller.clear();
              },
              child: const Icon(Icons.add),
            ),
            body: ListView(
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
                        ),
                      ),
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
