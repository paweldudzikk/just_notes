import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_notes/app/daily_task/daily_tasks/daily_task.dart';
import 'package:just_notes/app/home/home_page.dart';
import 'package:just_notes/app/note_book/note_book.dart';

class FirstPage extends StatefulWidget {
  FirstPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
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
          return HomePage(user: widget.user);
        }

        return HomePage(user: widget.user);
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
