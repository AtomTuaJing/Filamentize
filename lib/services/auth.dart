import 'package:filamentize2/services/notConnected_or_Connected.dart';
import 'package:filamentize2/services/signIn_or_signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const NotConnectedOrConnected();
          } else {
            return const SignInOrSignUp();
          }
        });
  }
}
