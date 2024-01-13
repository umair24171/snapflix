import 'package:snapflix/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatListOptions extends StatelessWidget {
  const ChatListOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: AppColors.whiteColor)),
        width: double.infinity,
        child: "Say Hello"
            .text
            .minFontSize(13)
            .maxFontSize(15)
            .color(AppColors.whiteColor)
            .maxLines(2)
            .ellipsis
            .make());
  }
}
