import 'package:snapflix/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PaymentOptionButtons extends StatelessWidget {
  const PaymentOptionButtons({
    super.key,
    required this.title,
    this.myIcon,
    this.imagePath,
  });
  final String? title;
  final Icon? myIcon;
  final String? imagePath;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HStack([
          myIcon != null
              ? myIcon!.p(10)
              : Image.asset(
                  imagePath!,
                  height: 30,
                  width: 30,
                ).p(10),
          "$title".text.color(AppColors.whiteColor).make(),
        ]),
        const Icon(
          Icons.more_vert,
          color: Colors.white,
        ).box.alignBottomRight.make().pOnly(right: 10)
      ],
    )
        .box
        .width(width * 0.9)
        .rounded
        .color(AppColors.lightWhite)
        .make()
        .pOnly(top: 20, left: 10, right: 10)
        .centered();
  }
}
