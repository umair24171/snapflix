import 'package:dotted_border/dotted_border.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Constants/app_images.dart';
import 'package:snapflix/Custom%20Widgets/custom_button.dart';
import 'package:snapflix/Screens/Payment%20Sections/widgets/payment_option_buttons.dart';
import 'package:snapflix/Screens/Payment%20Sections/widgets/payment_proceed.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  double price = 1.29;

  void increasePrice() {
    setState(() {
      price += 1.29;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.lightWhite,
        title: 'Payment Method'.text.maxFontSize(18).minFontSize(16).make(),
      ),
      body: VStack(
        [
          VStack(
            [
              HStack(
                spacing: width * 0.25,
                [
                  HStack([
                    IconButton(
                        icon: Image.asset(
                          AppImages.coinImage,
                          width: 20,
                          height: 20,
                        ),
                        onPressed: () {}),
                    "100 token"
                        .text
                        .color(AppColors.whiteColor)
                        .maxFontSize(16)
                        .minFontSize(14)
                        .make(),
                  ]),
                  customButton(
                    context,
                    buttonColor: AppColors.textPink,
                    onTapedFunc: () {
                      increasePrice();
                    },
                    title: "+ Apply Coupon",
                    titleColor: AppColors.whiteColor,
                  ).pOnly(top: 10),
                ],
              ),
              const Divider(
                color: Colors.grey,
              ).p(10),
              HStack(
                spacing: width * 0.5,
                [
                  "Total Price"
                      .text
                      .color(AppColors.whiteColor)
                      .maxFontSize(16)
                      .minFontSize(14)
                      .make()
                      .pOnly(left: 10, bottom: 20),
                  '\$${price.toStringAsFixed(1)}'
                      .text
                      .color(AppColors.whiteColor)
                      .maxFontSize(18)
                      .minFontSize(16)
                      .make()
                      .pOnly(left: 10, bottom: 20),
                ],
              ),
            ],
          ).box.rounded.color(AppColors.lightWhite).make().p(10),
          VStack(
            [
              const PaymentOptionButtons(
                  title: "Apple Pay",
                  myIcon: Icon(
                    Icons.apple,
                    color: AppColors.whiteColor,
                    size: 30,
                  )),
              const PaymentOptionButtons(
                title: "Visa",
                imagePath: AppImages.downloadImage,
              ),
              const PaymentOptionButtons(
                title: "Master Card",
                imagePath: AppImages.masterCardImage,
              ),
              const PaymentOptionButtons(
                title: "Local Debit",
                myIcon: Icon(
                  Icons.payment,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              ),
              DottedBorder(
                dashPattern: const [6, 6, 6, 6],
                color: Colors.pinkAccent,
                strokeWidth: 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: SizedBox(
                    height: 40,
                    child: HStack(
                      [
                        const Icon(
                          Icons.add,
                          color: Colors.pinkAccent,
                        ),
                        "Add Debit/Credit Card"
                            .text
                            .color(AppColors.textPink)
                            .make()
                      ],
                    ).centered(),
                  ),
                ),
              ).pOnly(left: 10, right: 10, bottom: 10, top: 20),
              customButton(context, buttonColor: AppColors.textPink,
                      onTapedFunc: () {
                navPush(context, PaymentProceed(updatedPrice: price));
              }, title: "Proceed to payment", titleColor: AppColors.whiteColor)
                  .pOnly(top: 12, bottom: 20, left: 12, right: 12),
            ],
          ).box.color(AppColors.lightWhite).rounded.make().p12(),
        ],
      ).scrollVertical(),
    );
  }
}
