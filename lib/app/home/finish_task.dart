import 'package:flutter/material.dart';

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
    );
  }
}
