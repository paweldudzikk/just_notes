import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 161, 152, 136),
      ),
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
          'Tracz',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
