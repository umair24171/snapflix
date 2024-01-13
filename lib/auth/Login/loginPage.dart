// ignore_for_file: use_build_context_synchronously
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Custom%20Widgets/custom_button.dart';

import 'package:snapflix/Utils/bottom_navigation.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/Custom%20Widgets/social_buttons.dart';
import 'package:snapflix/auth/SignUp/registerPage.dart';
import 'package:snapflix/firebase_methods/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLading = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: VStack(
        [
          "Welcome here".text.color(AppColors.whiteColor).semiBold.make().p20(),
          "Please Login with your email"
              .text
              .minFontSize(18)
              .bold
              .color(AppColors.whiteColor)
              .make()
              .pOnly(
                left: 20,
              ),
          VStack([
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: "enter your email",
                hintStyle: TextStyle(color: AppColors.greColor, fontSize: 13),
                labelText: "Email",
                labelStyle: TextStyle(color: AppColors.greColor),
                border: InputBorder.none,
              ),
              validator: RequiredValidator(errorText: "email is required"),
              style: const TextStyle(color: AppColors.whiteColor),
            ).pOnly(left: 10, right: 10, bottom: 5)
          ])
              .box
              .color(AppColors.lightWhite)
              .border(color: AppColors.lightWhite)
              .topRounded()
              .make()
              .pOnly(
                left: 20,
                right: 20,
                top: 30,
              ),
          VStack([
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: "enter your password",
                hintStyle: TextStyle(color: AppColors.greColor, fontSize: 13),
                labelText: "Password",
                labelStyle: TextStyle(color: AppColors.greColor),
                border: InputBorder.none,
              ),
              validator: RequiredValidator(errorText: "password is required"),
              style: const TextStyle(color: AppColors.whiteColor),
            ).pOnly(left: 10, right: 10, bottom: 5)
          ])
              .box
              .color(AppColors.lightWhite)
              .border(color: AppColors.lightWhite)
              .bottomRounded()
              .make()
              .pOnly(
                left: 20,
                right: 20,
              ),
          Container(
            alignment: Alignment.topRight,
            child: TextButton(
                onPressed: () {},
                child: "Have you forget password ?"
                    .text
                    .underline
                    .minFontSize(6)
                    .maxFontSize(12)
                    .color(AppColors.whiteColor)
                    .make()),
          ),
          isLading
              ? const CircularProgressIndicator(
                  color: AppColors.pinkColor,
                )
              : customButton(
                  context,
                  title: "Login",
                  onTapedFunc: () {
                    if (_emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      setState(() {
                        isLading = true;
                      });
                      AuthMethods().userLogin(
                          context: context,
                          email: _emailController.text,
                          password: _passwordController.text,
                          isLoading: isLading);
                      setState(() {
                        isLading = false;
                      });
                    }
                  },
                  titleColor: AppColors.whiteColor,
                ).pOnly(
                  left: 20,
                  right: 20,
                ),
          HStack([
            Container(
              height: height * 0.002,
              width: width * 0.4,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
              ),
            ).pOnly(left: 10),
            "OR".text.bold.color(AppColors.whiteColor).make().pOnly(
                  left: 10,
                ),
            Container(
              height: height * 0.002,
              width: width * 0.42,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
              ),
            ).pOnly(left: 10, right: 10)
          ]).pOnly(top: 20),
          "Login with".text.color(AppColors.whiteColor).make().centered(),
          InkWell(
            onTap: () async {
              bool value = await AuthMethods().signInWithGoogle(context);
              if (value) {
                navReplace(context, BottomNavigationBarSet());
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.lightWhite,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/google_logo.png',
                        height: 30,
                        width: 30,
                      ),
                      const Text(
                        'Continue with Google',
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                      const SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // socialButton(
          //     context, "assets/images/google_logo.png", "Continue with Google",
          //     () {
          //   AuthMethods().signInWithGoogle(context);

          //   navReplace(context, const BottomNavigationBarSet());
          // }),
          socialButton(context, "assets/images/facebook_icon.png",
              "Continue with Facebook", () async {}),
          socialButton(context, "assets/images/apple_icon.png",
              "Continue with apple", () {}),
          HStack([
            "Don't have an account ?".text.color(AppColors.whiteColor).make(),
            TextButton(
                onPressed: () {
                  navPush(context, const RegsiterPage());
                },
                child: "Regsiter".text.color(AppColors.pinkColor).make())
          ]).centered().pOnly(top: 20, bottom: 20)
        ],
      ).scrollVertical().pOnly(top: 30),
    );
  }
}
