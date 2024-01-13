import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Custom%20Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PaymentProceed extends StatefulWidget {
  final double updatedPrice;
  const PaymentProceed({super.key, required this.updatedPrice});

  @override
  State<PaymentProceed> createState() => _PaymentProceedState();
}

double? displayedPrice;

class _PaymentProceedState extends State<PaymentProceed> {
  @override
  void initState() {
    super.initState();
    displayedPrice = widget.updatedPrice;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        centerTitle: true,
        title: "Payment".text.make(),
        backgroundColor: AppColors.lightWhite,
      ),
      body: VStack([
        VStack([
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Current Balance"
                  .text
                  .color(AppColors.whiteColor)
                  .maxFontSize(18)
                  .minFontSize(16)
                  .make()
                  .p(10),
              "+ Add".text.color(AppColors.pinkColor).make().pOnly(right: 10),
            ],
          ),
          "373"
              .text
              .bold
              .color(AppColors.textPink)
              .maxFontSize(26)
              .minFontSize(22)
              .make()
              .pOnly(left: 20),
        ])
            .box
            .rounded
            .color(AppColors.lightWhite)
            .make()
            .pOnly(left: 15, right: 15, top: 20, bottom: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            "By token"
                .text
                .color(AppColors.whiteColor)
                .make()
                .box
                .alignTopLeft
                .make()
                .pOnly(left: 10, right: 10, top: 10, bottom: 10),
            customButton(
              context,
              title: "\$${displayedPrice!.toStringAsFixed(1)}",
              titleColor: AppColors.whiteColor,
              buttonColor: AppColors.textPink,
            ).w(width * 0.3).p(10),
            customButton(
              context,
              title: "\$${displayedPrice!.toStringAsFixed(1)}",
              titleColor: AppColors.whiteColor,
              buttonColor: AppColors.textPink,
            ).w(width * 0.3).p(10),
            customButton(
              context,
              title: "\$${displayedPrice!.toStringAsFixed(1)}",
              titleColor: AppColors.whiteColor,
              buttonColor: AppColors.textPink,
            ).w(width * 0.3).p(10),
            TextButton(
              onPressed: () {},
              child: "+ Apply Coupon".text.color(AppColors.textPink).make(),
            ).box.alignBottomLeft.make().p(10)
          ],
        )
            .box
            .rounded
            .color(AppColors.lightWhite)
            .make()
            .pOnly(left: 10, right: 10),
      ]),
    );
  }
}
