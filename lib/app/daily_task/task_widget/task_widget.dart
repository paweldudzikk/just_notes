import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_notes/app/daily_task/task_widget/cubit/task_widget_cubit.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget(
    this.title, {
    required this.docId,
    required this.onTaskFinished,
    this.isStrikethrough = false,
    Key? key,
  }) : super(key: key);

  final String title;
  final String docId;
  final Function onTaskFinished;
  final bool isStrikethrough;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> with TickerProviderStateMixin {
  late bool isStrikethrough;
  late AnimationController _cornerController;
  late Animation<Offset> _cornerAnimation;

  @override
  void initState() {
    super.initState();
    isStrikethrough = widget.isStrikethrough;

    _cornerController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _cornerAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _cornerController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _cornerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskWidgetCubit(),
      child: SlideTransition(
        position: _cornerAnimation,
        child: GestureDetector(
          onTap: () {
            setState(() {
              isStrikethrough = !isStrikethrough;
            });

            if (isStrikethrough) {
              _cornerController.forward().then((_) {
                widget.onTaskFinished(widget.docId, widget.title);
              });
            }
          },
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
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  child: isStrikethrough
                      ? const Icon(Icons.check, size: 15, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        decoration: isStrikethrough
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    context
                        .read<TaskWidgetCubit>()
                        .pickDateTime(context, widget.title);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
