import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_button.dart';
import 'package:filamentize2/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  final Function()? toggleLoginPage;
  const SignUpPage({super.key, required this.toggleLoginPage});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // sign in method
  Future<void> signUp() async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      showMessage("Passwords don't match");
      return;
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({"username": nameController.text, "wallet": 0});

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showMessage(e.code);
    }
  }

  // show message
  void showMessage(String text) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: ColorsAsset.white,
              title: Text(text,
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("OK",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: ColorsAsset.green)))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAsset.green,
      body: Column(
        children: [
          const SizedBox(height: 100),
          // container
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: ColorsAsset.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Column(
                    children: [
                      const SizedBox(height: 43),
                      // create your account
                      Text("Create your account",
                          style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: ColorsAsset.dark)),

                      const SizedBox(height: 40),

                      // name textfield
                      MyTextField(
                          iconData: Icons.person_outline,
                          textEditingController: nameController,
                          hintText: "Name"),

                      const SizedBox(height: 30),

                      // email textfield
                      MyTextField(
                          iconData: Icons.email_outlined,
                          textEditingController: emailController,
                          hintText: "Email"),

                      const SizedBox(height: 30),

                      // password textfield
                      MyTextField(
                          iconData: Icons.lock_outline,
                          textEditingController: passwordController,
                          hintText: "Password",
                          obsecureText: true),

                      const SizedBox(height: 30),

                      // confirm password textfield
                      MyTextField(
                          iconData: Icons.lock_outline,
                          textEditingController: confirmPasswordController,
                          hintText: "Confirm Password",
                          obsecureText: true),

                      const SizedBox(height: 40),

                      // sign up button
                      GestureDetector(
                        onTap: signUp,
                        child: MyButton(
                            text: "Sign Up",
                            color: ColorsAsset.green,
                            textColor: ColorsAsset.white),
                      ),

                      const SizedBox(height: 70),

                      // already have an account? Sign In
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // already have an account?
                          Text("Already have an account?",
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsAsset.dark)),

                          const SizedBox(width: 5),

                          // sign in
                          GestureDetector(
                            onTap: widget.toggleLoginPage,
                            child: Text("Sign In",
                                style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsAsset.green)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
