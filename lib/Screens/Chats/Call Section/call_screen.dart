import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Constants/app_images.dart';
import 'package:snapflix/Utils/call_row_buttons.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({
    super.key,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 0,
            child: CallRowButtons(),
          ),
          Positioned(
            top: height * 0.25,
            left: width * 0.27,
            child: VStack(
              alignment: MainAxisAlignment.center,
              crossAlignment: CrossAxisAlignment.center,
              [
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(AppImages.vedioCallImage),
                ),
                "Amanda"
                    .text
                    .color(AppColors.whiteColor)
                    .minFontSize(12)
                    .maxFontSize(14)
                    .make()
                    .pOnly(top: 10),
              ],
            ),
          ),
        ],
      ).centered(),
    );
  }
}
