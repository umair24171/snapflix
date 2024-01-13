import "dart:io";

import 'package:snapflix/Constants/app_colors.dart';
import "package:snapflix/Custom%20Widgets/custom_button.dart";
import "package:snapflix/Custom%20Widgets/custom_text_fields.dart";

import "package:snapflix/Utils/bottom_navigation.dart";
import "package:snapflix/Utils/navigator.dart";
import "package:flutter/material.dart";
import "package:velocity_x/velocity_x.dart";

class AgeVerification extends StatefulWidget {
  const AgeVerification({super.key});

  @override
  State<AgeVerification> createState() => _AgeVerificationState();
}

class _AgeVerificationState extends State<AgeVerification> {
  DateTime selectedDate = DateTime.now();

  Future<void> showDateChooser(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2023),
        lastDate: DateTime(2021));
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    File? image;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColors.lightWhite,
          title: "Age Verification"
              .text
              .minFontSize(16)
              .maxFontSize(18)
              .color(AppColors.whiteColor)
              .bold
              .make(),
          centerTitle: true,
        ),
      ),
      backgroundColor: AppColors.blackColor,
      body: VStack([
        "Date of Birth"
            .text
            .semiBold
            .maxFontSize(17)
            .minFontSize(15)
            .color(AppColors.greColor)
            .make()
            .pOnly(left: 20, top: 20),
        customTextField(
            hintTitle: "enter your date of birth",
            borderColor: AppColors.greColor,
            boxColor: AppColors.lightWhite,
            hintColor: AppColors.lightText,
            suffixIconButton: IconButton(
                onPressed: () {
                  showDateChooser(context);
                },
                icon: const Icon(
                  Icons.calendar_month,
                  color: AppColors.whiteColor,
                ))),
        HStack([
          Checkbox(value: true, onChanged: (val) {}),
          "Confrim the user is of legal age"
              .text
              .color(AppColors.whiteColor)
              .make()
        ]).pOnly(left: 10),
        "Upoad ID"
            .text
            .semiBold
            .maxFontSize(17)
            .minFontSize(15)
            .color(AppColors.greColor)
            .make()
            .pOnly(left: 20, top: 20),
        Container(
          height: height * 0.3,
          width: width * 0.9,
          decoration: BoxDecoration(
              color: AppColors.lightWhite,
              borderRadius: BorderRadius.circular(20)),
          child: image == null
              ? VStack([
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.cloud_circle_outlined,
                        color: AppColors.lightText,
                        size: 50,
                      )).centered().pOnly(bottom: 10),
                  "Upload id image"
                      .text
                      .color(AppColors.lightText)
                      .make()
                      .centered()
                ]).centered()
              : const SizedBox(),
        ).centered().pOnly(top: 10),
        customButton(context, title: "Next", titleColor: AppColors.whiteColor,
            onTapedFunc: () {
          navPush(context, BottomNavigationBarSet());
        }).pOnly(left: 20, right: 20, top: height * 0.09),
      ]),
    );
  }
}
