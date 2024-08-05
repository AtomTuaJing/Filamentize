import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/services/languages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // input controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var languageController = TextEditingController();

  // selected language
  var selectedLanguage;
  var hintTextLanguage;

  // image file
  File? selectedImage;
  var loadImage;

  // current user
  var currentUser = FirebaseAuth.instance.currentUser;

  // state
  var loadState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(AppLocale.editProfile.getString(context),
            style: GoogleFonts.montserrat(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(currentUser!.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var userData = snapshot.data!.data() as Map<String, dynamic>;
                if (userData["language"] == "en") {
                  hintTextLanguage = "English";
                }
                if (userData["language"] == "cn") {
                  hintTextLanguage = "Chinese";
                }
                if (userData["language"] == "th") {
                  hintTextLanguage = "Thailand";
                }
                loadImage = userData["profile"];
                if (loadImage != "") {
                  loadState = true;
                }
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 23.w),
                    child: Column(
                      children: [
                        SizedBox(height: 30.h),

                        // edit image
                        Center(
                          child: GestureDetector(
                            onTap: pickImageFromGallery,
                            child: loadImage != ""
                                ? GestureDetector(
                                    onTap: () async {
                                      await FirebaseFirestore.instance
                                          .collection("Users")
                                          .doc(currentUser!.email)
                                          .update({"profile": ""});
                                    },
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(
                                          color: ColorsAsset.grey,
                                          shape: BoxShape.circle),
                                      child: Image.network(
                                        loadImage,
                                        width: 110.w,
                                        height: 110.h,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                                : selectedImage != null
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedImage = null;
                                          });
                                        },
                                        child: Container(
                                          clipBehavior: Clip.hardEdge,
                                          decoration: const BoxDecoration(
                                              color: ColorsAsset.grey,
                                              shape: BoxShape.circle),
                                          child: Image.file(
                                            selectedImage!,
                                            width: 110.w,
                                            height: 110.h,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.w, vertical: 40.h),
                                        decoration: const BoxDecoration(
                                            color: ColorsAsset.grey,
                                            shape: BoxShape.circle),
                                        child: SvgPicture.asset(
                                          "images/icons/photo_auto_merge.svg",
                                          width: 33.w,
                                          colorFilter: const ColorFilter.mode(
                                              Colors.black, BlendMode.srcIn),
                                        ),
                                      ),
                          ),
                        ),

                        SizedBox(height: 30.h),

                        // name
                        Padding(
                          padding: EdgeInsets.only(left: 7.w, top: 5.h),
                          child: TextField(
                            controller: nameController,
                            cursorColor: ColorsAsset.green,
                            style: GoogleFonts.montserrat(
                                fontSize: 16.sp, fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.person_outline,
                                  size: 27.sp,
                                  color: Colors.black,
                                ),
                                hintText: userData["username"],
                                hintStyle: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    color: ColorsAsset.littleGrey),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                          ),
                        ),

                        Divider(
                          thickness: 2.sp,
                        ),

                        SizedBox(
                          height: 12.h,
                        ),

                        // email
                        Padding(
                          padding: EdgeInsets.only(left: 7.w, top: 5.h),
                          child: TextField(
                            controller: emailController,
                            cursorColor: ColorsAsset.green,
                            style: GoogleFonts.montserrat(
                                fontSize: 16.sp, fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.mail_outline,
                                  size: 27.sp,
                                  color: Colors.black,
                                ),
                                hintText: currentUser!.email,
                                hintStyle: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    color: ColorsAsset.littleGrey),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                          ),
                        ),

                        Divider(
                          thickness: 2.sp,
                        ),

                        SizedBox(
                          height: 12.h,
                        ),

                        // language
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Text("Languages",
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      content: StatefulBuilder(
                                          builder: (context, setState) {
                                        return SizedBox(
                                          height: 180.h,
                                          child: Column(
                                            children: [
                                              // english
                                              RadioListTile(
                                                value: "English",
                                                groupValue: selectedLanguage,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedLanguage = newValue;
                                                  });
                                                },
                                                activeColor: ColorsAsset.green,
                                                title: Text("English",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black)),
                                              ),

                                              // chinese
                                              RadioListTile(
                                                value: "Chinese",
                                                groupValue: selectedLanguage,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedLanguage = newValue;
                                                  });
                                                },
                                                activeColor: ColorsAsset.green,
                                                title: Text("Chinese",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black)),
                                              ),

                                              // thailand
                                              RadioListTile(
                                                value: "Thailand",
                                                groupValue: selectedLanguage,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedLanguage = newValue;
                                                  });
                                                },
                                                activeColor: ColorsAsset.green,
                                                title: Text("Thailand",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black)),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                      actions: [
                                        // cancel
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                                AppLocale.cancel
                                                    .getString(context),
                                                style: GoogleFonts.montserrat(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: ColorsAsset.red))),

                                        // ok
                                        TextButton(
                                            onPressed: () {
                                              languageController.text =
                                                  selectedLanguage;
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                                AppLocale.ok.getString(context),
                                                style: GoogleFonts.montserrat(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: ColorsAsset.green)))
                                      ],
                                    ));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 7.w, top: 5.h),
                            child: TextField(
                              enabled: false,
                              controller: languageController,
                              cursorColor: ColorsAsset.green,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.public,
                                  size: 27.sp,
                                  color: Colors.black,
                                ),
                                hintText: hintTextLanguage,
                                hintStyle: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                                disabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                              ),
                            ),
                          ),
                        ),

                        Divider(
                          thickness: 2.sp,
                        ),

                        SizedBox(height: 36.h),

                        // edit button
                        GestureDetector(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) => const Center(
                                    child: CircularProgressIndicator(
                                        color: ColorsAsset.green)));
                            try {
                              var convertedLanguage;
                              if (languageController.text == "English") {
                                convertedLanguage = "en";
                              }
                              if (languageController.text == "Chinese") {
                                convertedLanguage = "cn";
                              }
                              if (languageController.text == "Thailand") {
                                convertedLanguage = "th";
                              }
                              if (languageController.text == "") {
                                convertedLanguage = "en";
                              }

                              var downloadUrl;

                              if (selectedImage != null) {
                                final storageRef = FirebaseStorage.instance
                                    .ref()
                                    .child("images/${selectedImage!.path}");

                                final uploadTask =
                                    await storageRef.putFile(selectedImage!);

                                downloadUrl =
                                    await uploadTask.ref.getDownloadURL();
                              }

                              await FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(currentUser!.email)
                                  .update({
                                "username": nameController.text == ""
                                    ? userData["username"]
                                    : nameController.text,
                                "language": convertedLanguage,
                                "profile": downloadUrl ?? userData["profile"]
                              });

                              Navigator.pop(context);
                              Navigator.pop(context, "refresh");
                            } catch (e) {
                              print(e);
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text(
                                            AppLocale.error.getString(context),
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.bold,
                                                color: ColorsAsset.red)),
                                        content: Text(
                                            "${AppLocale.error.getString(context)}...",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black)),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                  AppLocale.ok
                                                      .getString(context),
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          ColorsAsset.green)))
                                        ],
                                      ));
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 44.h,
                            decoration: BoxDecoration(
                                color: ColorsAsset.green,
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // icon
                                Icon(Icons.border_color_outlined,
                                    size: 23.sp, color: Colors.white),

                                SizedBox(width: 7.w),

                                // edit
                                Text(
                                  AppLocale.set.getString(context),
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                  child: CircularProgressIndicator(color: ColorsAsset.green));
            }),
      ),
    );
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    setState(() {
      selectedImage = File(returnedImage.path);
    });
  }
}
