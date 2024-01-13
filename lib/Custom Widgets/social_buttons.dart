import 'package:snapflix/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget socialButton(
    context, String logoPath, String platform, Function onTapeFucn) {
  return HStack([
    Image.asset(logoPath)
        .box
        .withRounded(value: 20)
        .height(MediaQuery.of(context).size.height * 0.05)
        .make()
        .pOnly(left: 10),
    TextButton(
        onPressed: () {
          onTapeFucn;
        },
        child:
            platform.text.color(AppColors.whiteColor).make().pOnly(left: 20)),
  ])
      .box
      .height(MediaQuery.of(context).size.height * 0.07)
      .width(MediaQuery.of(context).size.width * 0.9)
      .color(AppColors.lightWhite)
      .rounded
      .make()
      .onInkTap(() {
        onTapeFucn;
      })
      .centered()
      .pOnly(top: 20);
}
