import 'package:filamentize2/pages/sign_in_page.dart';
import 'package:filamentize2/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class SignInOrSignUp extends StatefulWidget {
  const SignInOrSignUp({super.key});

  @override
  State<SignInOrSignUp> createState() => _SignInOrSignUpState();
}

class _SignInOrSignUpState extends State<SignInOrSignUp> {
  // initially set to sign in page
  bool isShowSignIn = true;

  void toggleLoginPage() {
    setState(() {
      isShowSignIn = !isShowSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isShowSignIn) {
      return SignInPage(toggleLoginPage: toggleLoginPage);
    } else {
      return SignUpPage(toggleLoginPage: toggleLoginPage);
    }
  }
}
