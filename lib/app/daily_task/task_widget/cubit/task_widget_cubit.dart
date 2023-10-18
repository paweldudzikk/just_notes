
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'task_widget_state.dart';

class TaskWidgetCubit extends Cubit<TaskWidgetState> {
  TaskWidgetCubit() : super(const TaskWidgetState(isStrikethrough: false));

  Future<void> toggleStrikethrough() async {
    final newState = !state.isStrikethrough;
    emit(TaskWidgetState(isStrikethrough: newState));
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

  Future<void> pickDateTime(BuildContext context, String title) async {
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
      scheduleNotification(
        scheduledDate,
        title,
      );
    }
  }
}
