import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_notes/app/daily_task/finished_task/cubit/finished_task_cubit.dart';
import 'package:just_notes/app/daily_task/finished_task/cubit/finished_task_state.dart';
import 'package:just_notes/app/daily_task/repositories/finish_task_repository.dart';
import 'package:just_notes/app/daily_task/task_widget/task_widget.dart';

class FinishTask extends StatelessWidget {
  const FinishTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 161, 152, 136),
        title: const Text(
          'Finished Task',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: BlocProvider(
        create: (context) => FinishedTaskCubit(
          FinishedTaskRepository(),
        )..start(),
        child: BlocBuilder<FinishedTaskCubit, FinishedTaskState>(
          builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return Text(
                  'An unexpected error occurred: ${state.errorMessage}');
            }

            if (state.isLoading) {
              return const Text('Please wait while loading data');
            }

            final finishedTaskModels = state.documents;

            return ListView(
              children: [
                for (final finishedTaskModel in finishedTaskModels)
                  TaskWidget(
                    finishedTaskModel.title,
                    docId: finishedTaskModel.id,
                    onTaskFinished: (String docId, String title) {},
                    isStrikethrough: true,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
