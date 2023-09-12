import 'package:flutter/material.dart';
import 'package:just_notes/app/daily_task/daily_task.dart';
import 'package:just_notes/app/note_book/note_book.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 234, 226),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return DailyTask();
        }

        if (currentIndex == 1) {
          return const Notebook();
        }

        if (currentIndex == 2) {
          return DailyTask();
        }

        return DailyTask();
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Daily task'),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Notebook',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'My Account'),
        ],
      ),
    );
  }
}
