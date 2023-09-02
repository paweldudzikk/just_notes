import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget(
    this.title, {
    super.key,
  });

  final String title;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

bool isStrikethrough = false;

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 161, 152, 136),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isStrikethrough = !isStrikethrough;
              });
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
              ),
              child: isStrikethrough
                  ? const Icon(Icons.check, size: 15, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              decoration: isStrikethrough
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
