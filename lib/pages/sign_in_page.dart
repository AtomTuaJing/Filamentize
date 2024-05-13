import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_button.dart';
import 'package:filamentize2/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatefulWidget {
  final Function()? toggleLoginPage;
  const SignInPage({super.key, required this.toggleLoginPage});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAsset.green,
      body: Column(
        children: [
          SizedBox(height: 125),
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
                    SizedBox(height: 40),
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
                                color: Color(0xff939393)))
                      ],
                    ),
                    SizedBox(height: 50),

                    // mail textfield
                    MyTextField(
                      iconData: Icons.mail_outline,
                      textEditingController: emailController,
                      hintText: "Mail",
                    ),

                    SizedBox(height: 30),

                    // password textfield
                    MyTextField(
                        iconData: Icons.lock_outline,
                        textEditingController: passwordController,
                        hintText: "Password"),

                    SizedBox(height: 50),

                    // sign in button
                    MyButton(
                        text: "Sign In",
                        color: ColorsAsset.green,
                        textColor: ColorsAsset.white),

                    SizedBox(height: 140),

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

                        SizedBox(width: 5),

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
          )
        ],
      ),
    );
  }
}
