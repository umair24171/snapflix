import 'package:snapflix/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customButton(
  context, {
  String? title,
  Function()? onTapedFunc,
  Color? titleColor,
  Color? buttonColor,
}) {
  return TextButton(
          onPressed: onTapedFunc,
          child: title!.text.bold.color(titleColor).make().centered())
      .box
      .color(buttonColor ?? AppColors.pinkColor)
      .height(MediaQuery.of(context).size.height * 0.07)
      .rounded
      .make()
      .onTap(() {
    onTapedFunc;
  });
}

Widget customRowButtons(String name, height, width, bool check) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
          color: check ? AppColors.transparentColor : AppColors.lightWhite),
      color: check ? AppColors.pinkColor : AppColors.lightWhite,
    ),
    child: name.text
        .color(check ? Colors.white : AppColors.lightText)
        .minFontSize(12)
        .maxFontSize(14)
        .make()
        .centered(),
  ).pOnly(left: 10, top: 10, right: 10);
}
