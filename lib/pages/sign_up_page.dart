import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_button.dart';
import 'package:filamentize2/components/my_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAsset.green,
      body: Column(
        children: [
          SizedBox(height: 100),
          // container
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorsAsset.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  children: [
                    SizedBox(height: 43),
                    // create your account
                    Text("Create your account",
                        style: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColorsAsset.dark)),

                    SizedBox(height: 40),

                    // name textfield
                    MyTextField(
                        iconData: Icons.person_outline,
                        textEditingController: nameController,
                        hintText: "Name"),

                    SizedBox(height: 30),

                    // email textfield
                    MyTextField(
                        iconData: Icons.email_outlined,
                        textEditingController: emailController,
                        hintText: "Email"),

                    SizedBox(height: 30),

                    // password textfield
                    MyTextField(
                        iconData: Icons.lock_outline,
                        textEditingController: passwordController,
                        hintText: "Password"),

                    SizedBox(height: 30),

                    // confirm password textfield
                    MyTextField(
                        iconData: Icons.lock_outline,
                        textEditingController: confirmPasswordController,
                        hintText: "Confirm Password"),

                    SizedBox(height: 40),

                    // sign up button
                    MyButton(
                        text: "Sign Up",
                        color: ColorsAsset.littleGrey,
                        textColor: ColorsAsset.white),

                    SizedBox(height: 90),

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

                        SizedBox(width: 5),

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
          )
        ],
      ),
    );
  }
}
