import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Constants/app_images.dart';
import 'package:snapflix/Utils/call_row_buttons.dart';
import 'package:snapflix/models/call_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Callback extends StatelessWidget {
  const Callback({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('calls')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Call call = Call.fromMap(snapshot.data!.data()!);
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    call.receiverPic,
                    fit: BoxFit.cover,
                  ).box.height(MediaQuery.of(context).size.height).make(),
                  Positioned(
                    bottom: 0,
                    child: CallRowButtons(call: call),
                  ),
                  Positioned(
                    top: 100,
                    right: 30,
                    child: Image.network(
                      call.callerPic,
                      fit: BoxFit.cover,
                    )
                        .box
                        .border(color: AppColors.blackColor)
                        .height(height * 0.25)
                        .width(width * 0.4)
                        .make(),
                  )
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
