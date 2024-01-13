// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Custom%20Widgets/custom_button.dart';
import 'package:snapflix/Custom%20Widgets/custom_text_fields.dart';
import 'package:snapflix/Utils/additional_methods.dart';

import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/auth/SignUp/age_verification.dart';
import 'package:snapflix/firebase_methods/auth_methods.dart';
import 'package:snapflix/firebase_methods/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class RegsiterPage extends StatefulWidget {
  const RegsiterPage({super.key});

  @override
  State<RegsiterPage> createState() => _RegsiterPageState();
}

class _RegsiterPageState extends State<RegsiterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  File? image;
  // String? photoUrl;

  selectImageFromFile() async {
    File pickedImage = await FirestoreHelper().pickImage();

    setState(() {
      image = pickedImage;
      // photoUrl = photoUrl1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.blackColor,
        body: VStack([
          "Register yourself"
              .text
              .minFontSize(16)
              .maxFontSize(18)
              .bold
              .color(AppColors.whiteColor)
              .make()
              .centered()
              .pOnly(top: height * 0.07, bottom: height * 0.04),
          DottedBorder(
            child: Container(
              height: height * 0.25,
              width: width * 0.45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    90,
                  ),
                  color: AppColors.lightWhite,
                  border: Border.all(
                    color: AppColors.lightText,
                    style: BorderStyle.solid,
                    width: 1.0,
                  )),
              child: image == null
                  ? VStack([
                      IconButton(
                          onPressed: selectImageFromFile,
                          icon: const Icon(
                            Icons.cloud_circle_outlined,
                            color: AppColors.lightText,
                          )).centered(),
                      "upload image"
                          .text
                          .color(AppColors.lightText)
                          .make()
                          .centered()
                    ]).centered().onInkTap(() {
                      // selectImageFromFile;
                    })
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Image.file(image!)
                          .centered()
                          .fittedBox(fit: BoxFit.fill)),
            ).centered(),
          ),
          customTextField(
              textController: _usernameController,
              hintTitle: "enter username",
              lableTitle: "UserName",
              hintColor: AppColors.lightText,
              labelColor: AppColors.lightText,
              borderColor: AppColors.lightText,
              boxColor: AppColors.lightWhite),
          customTextField(
              textController: _emailController,
              hintTitle: "enter your email",
              lableTitle: "Email",
              hintColor: AppColors.lightText,
              labelColor: AppColors.lightText,
              borderColor: AppColors.lightText,
              boxColor: AppColors.lightWhite),
          customTextField(
              textController: _passwordController,
              hintTitle: "enter your password",
              lableTitle: "Password",
              hintColor: AppColors.lightText,
              labelColor: AppColors.lightText,
              borderColor: AppColors.lightText,
              boxColor: AppColors.lightWhite),
          customTextField(
              textController: _confirmPasswordController,
              hintTitle: "enter confirm password",
              lableTitle: "Confirm Password",
              hintColor: AppColors.lightText,
              labelColor: AppColors.lightText,
              borderColor: AppColors.lightText,
              boxColor: AppColors.lightWhite),
          customButton(context,
              title: "SignUp",
              titleColor: AppColors.whiteColor, onTapedFunc: () async {
            if (_usernameController.text.isNotEmpty &&
                _emailController.text.isNotEmpty &&
                _passwordController.text.isNotEmpty &&
                _confirmPasswordController.text.isNotEmpty) {
              if (_passwordController.text == _confirmPasswordController.text) {
                String photoUrl = await FirestoreHelper()
                    .uploadFile('users', image!, context);
                print('photoUrl: $photoUrl');
                bool value = await AuthMethods().userSignUp(
                    email: _emailController.text,
                    password: _passwordController.text,
                    username: _usernameController.text,
                    confirmPassword: _confirmPasswordController.text,
                    photoUrl: photoUrl,
                    context: context);
                if (value) {
                  showSnackBar(
                      'Congratulations', 'User Registered Successfully');
                  navReplace(context, const AgeVerification());
                }
              }
            }
          }).pOnly(left: 20, right: 20, top: height * 0.1, bottom: 20)
        ]).scrollVertical());
  }
}
