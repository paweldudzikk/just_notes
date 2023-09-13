import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

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

    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
    );
  }

  Future<void> scheduleNotification(
      DateTime scheduledDate, String title) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: title,
        body: 'Czas na wykonanie zadania!',
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'MARK_DONE',
          label: 'Mark as Done',
        ),
      ],
      schedule: NotificationCalendar(
        second: scheduledDate.second,
        minute: scheduledDate.minute,
        hour: scheduledDate.hour,
        day: scheduledDate.day,
        month: scheduledDate.month,
        year: scheduledDate.year,
        repeats: false,
      ),
    );
  }

  Future<void> pickDateTime() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedDate != null && selectedTime != null) {
      DateTime scheduledDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      scheduleNotification(scheduledDate, widget.title);
    }
  }

  @override
  void dispose() {
    _cornerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _cornerAnimation,
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
                  _cornerController.forward().then((_) {
                    widget.onTaskFinished(widget.docId, widget.title);
                    _cornerController.reset();
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
                pickDateTime();
              },
            ),
          ],
        ),
      ),
    );
  }
}
