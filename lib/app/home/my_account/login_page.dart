import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    super.key,
  });

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMessage = '';
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isCreatingAccount == true ? 'Register' : 'Log in',
                style: const TextStyle(
                  fontSize: 50,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                controller: widget.emailController,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                controller: widget.passwordController,
                obscureText: true,
              ),
              Text(
                errorMessage,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (isCreatingAccount == true) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: widget.emailController.text,
                        password: widget.passwordController.text,
                      );
                    } catch (error) {
                      setState(() {
                        errorMessage = errorMessage.toString();
                      });
                    }
                  } else {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: widget.emailController.text,
                        password: widget.passwordController.text,
                      );
                    } catch (error) {
                      setState(() {
                        errorMessage = errorMessage.toString();
                      });
                    }
                  }
                },
                child: Text(
                  isCreatingAccount == true ? 'Register' : 'Log in',
                ),
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
                  } catch (error) {
                    setState(() {
                      errorMessage =
                          'Błąd logowania z Google: ${error.toString()}';
                    });
                    print(error);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/google.png', height: 24.0, width: 30.0),
                    const SizedBox(width: 8.0),
                    const Text('Log in with Google'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (isCreatingAccount == false) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = true;
                    });
                  },
                  child: const Text('Create Account'),
                )
              ],
              if (isCreatingAccount == true) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = false;
                    });
                  },
                  child: const Text('You already have account ?'),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}