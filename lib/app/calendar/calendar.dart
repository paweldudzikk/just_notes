import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';

class EventPage extends StatefulWidget {
  const EventPage({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  DateTime? startDate;
  DateTime? endDate;

  Future<DateTime?> _selectDateTime(
      BuildContext context, DateTime? currentValue) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      initialDate: currentValue ?? DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return currentValue;

    final TimeOfDay? pickedTime = await Future.delayed(Duration.zero, () {
      return showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
      );
    });

    if (pickedTime == null) return pickedDate;

    return DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
        pickedTime.hour, pickedTime.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Google calendar event',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 161, 152, 136),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DateTimeField(
                decoration: const InputDecoration(hintText: 'Event start'),
                format: format,
                onShowPicker: (context, currentValue) =>
                    _selectDateTime(context, currentValue),
                onChanged: (selectedDate) {
                  setState(() {
                    startDate = selectedDate;
                  });
                },
              ),
              const SizedBox(height: 20),
              DateTimeField(
                decoration: const InputDecoration(hintText: 'Event end'),
                format: format,
                onShowPicker: (context, currentValue) =>
                    _selectDateTime(context, currentValue),
                onChanged: (selectedDate) {
                  setState(() {
                    endDate = selectedDate;
                  });
                },
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration:
                    InputDecoration(hintText: 'Add what you want to do '),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 161, 152, 136),
                ),
                onPressed: () {},
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
