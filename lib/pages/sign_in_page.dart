import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_button.dart';
import 'package:filamentize2/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatefulWidget {
  final Function()? toggleLoginPage;
  const SignInPage({super.key, required this.toggleLoginPage});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // sign in method
  Future<void> signIn() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
                child: CircularProgressIndicator(
              color: ColorsAsset.green,
            )));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
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
          const SizedBox(height: 125),
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
                      const SizedBox(height: 40),
                      // filamentize account + image
                      Column(
                        children: [
                          // logo
                          Image.asset("images/logo.png", width: 67),

                          // filamentize
                          Text("Filamentize",
                              style: GoogleFonts.montserrat(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsAsset.dark)),

                          // account
                          Text("Account",
                              style: GoogleFonts.montserrat(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  height: 0.5,
                                  color: const Color(0xff939393)))
                        ],
                      ),
                      const SizedBox(height: 50),

                      // mail textfield
                      MyTextField(
                        iconData: Icons.mail_outline,
                        textEditingController: emailController,
                        hintText: "Mail",
                      ),

                      const SizedBox(height: 30),

                      // password textfield
                      MyTextField(
                          iconData: Icons.lock_outline,
                          textEditingController: passwordController,
                          hintText: "Password",
                          obsecureText: true),

                      const SizedBox(height: 50),

                      // sign in button
                      GestureDetector(
                        onTap: signIn,
                        child: MyButton(
                            text: "Sign In",
                            color: ColorsAsset.green,
                            textColor: ColorsAsset.white),
                      ),

                      const SizedBox(height: 120),

                      // dont have an account? create one!
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // dont have an account?
                          Text("Don't have an account?",
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsAsset.dark)),

                          const SizedBox(width: 5),

                          // create one!
                          GestureDetector(
                            onTap: widget.toggleLoginPage,
                            child: Text("Create One",
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
