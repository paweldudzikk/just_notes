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
      body: Column(
        children: [
          const TaskWidget(),
          const TaskWidget(),
          const TaskWidget(),
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
      ),
    );
  }
}
