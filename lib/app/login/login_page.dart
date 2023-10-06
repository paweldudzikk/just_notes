import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    super.key,
  });

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Just Notes',
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: ('email'),
                ),
                controller: emailController,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: ('password'),
                ),
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                },
                child: const Text('Log in'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final GoogleSignInAccount? googleSignInAccount =
                        await GoogleSignIn().signIn();
                    if (googleSignInAccount != null) {
                      final GoogleSignInAuthentication
                          googleSignInAuthentication =
                          await googleSignInAccount.authentication;
                      final AuthCredential credential =
                          GoogleAuthProvider.credential(
                        accessToken: googleSignInAuthentication.accessToken,
                        idToken: googleSignInAuthentication.idToken,
                      );
                      await FirebaseAuth.instance
                          .signInWithCredential(credential);
                    }
                  } catch (error) {}
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/google.png', height: 24.0, width: 30.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
