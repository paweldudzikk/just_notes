import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    super.key,
  });

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(),
              TextField(
                obscureText: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
