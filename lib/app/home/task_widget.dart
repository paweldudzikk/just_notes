import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget(
    this.title, {
    required this.docId,
    required this.onTaskFinished,
    super.key,
  });

  final String title;
  final String docId;
  final Function onTaskFinished;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> with TickerProviderStateMixin {
  bool isStrikethrough = false;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 161, 152, 136),
          borderRadius: BorderRadius.all(Radius.circular(20)),
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

                if (isStrikethrough) {
                  _animationController.forward().then((_) {
                    widget.onTaskFinished(widget.docId, widget.title);
                    _animationController.reset();
                  });
                }
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
      ),
    );
  }
}
