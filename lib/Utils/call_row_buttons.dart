import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/firebase_methods/call_methods.dart';
import 'package:snapflix/models/call_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CallRowButtons extends StatelessWidget {
  CallRowButtons({super.key, this.call});
  Call? call;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        "00:00"
            .text
            .bold
            .color(AppColors.whiteColor)
            .minFontSize(16)
            .maxFontSize(18)
            .make()
            .pOnly(bottom: height * 0.1)
            .centered(),
        HStack(
          alignment: MainAxisAlignment.spaceBetween,
          [
            const Icon(
              Icons.volume_up,
              size: 22,
              color: Colors.white,
            )
                .p(10)
                .box
                .roundedFull
                .color(
                  AppColors.lightWhite,
                )
                .make()
                .onTap(() {})
                .pOnly(right: 10),
            const Icon(
              Icons.videocam,
              color: AppColors.whiteColor,
              size: 20,
            )
                .p(10)
                .box
                .roundedFull
                .color(
                  AppColors.lightWhite,
                )
                .make()
                .onTap(() {})
                .pOnly(right: 10),
            const Icon(
              Icons.mic,
              color: AppColors.whiteColor,
            )
                .p(10)
                .box
                .roundedFull
                .color(
                  AppColors.lightWhite,
                )
                .make()
                .onTap(() {})
                .pOnly(right: 10),
            const Icon(
              Icons.call_end,
              color: Colors.red,
            )
                .p(10)
                .box
                .roundedFull
                .color(
                  AppColors.lightWhite,
                )
                .make()
                .onTap(() {
              CallMethods().endCall(call!.callerId, call!.receiverId);
              navPop(context);
            }).pOnly(right: 10),
          ],
        )
            .p(10)
            .box
            .topRounded()
            .width(width)
            .color(AppColors.blackColor)
            .make(),
      ],
    );
  }
}
