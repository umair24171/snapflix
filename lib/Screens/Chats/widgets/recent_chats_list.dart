import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Constants/app_images.dart';
import 'package:snapflix/Screens/Chats/Message%20Section/message_screen.dart';
import 'package:snapflix/Utils/navigator.dart';

import 'package:snapflix/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class RecentChatList extends StatelessWidget {
  const RecentChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('uid',
                  isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No chats yet"),
                );
              }

              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    UserModel userModel =
                        UserModel.fromMap(snapshot.data!.docs[index].data());
                    return ListTile(
                      leading: HStack([
                        const CircleAvatar(
                          backgroundImage: AssetImage(AppImages.profileAvatar),
                        ).pOnly(),
                      ]),
                      title: userModel.username.text
                          .minFontSize(12)
                          .maxFontSize(14)
                          .color(AppColors.whiteColor)
                          .make()
                          .box
                          .alignTopLeft
                          .make()
                          .centered(),
                      subtitle: 'Hello'
                          .text
                          .maxFontSize(14)
                          .minFontSize(12)
                          .color(AppColors.lightText)
                          .ellipsis
                          .maxLines(1)
                          .make(),
                      trailing:
                          "4:30 pm".text.color(AppColors.lightText).make(),
                    ).onInkTap(() {
                      navPush(
                          context,
                          MessageScreen(
                            user: userModel,
                          ));
                    });
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.pinkColor,
                ),
              );
            }
          }),
    );
  }
}
