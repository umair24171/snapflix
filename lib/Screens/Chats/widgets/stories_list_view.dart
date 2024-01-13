import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

class MyStoriesList extends StatelessWidget {
  const MyStoriesList({Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('uid',
                  isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    UserModel user =
                        UserModel.fromMap(snapshot.data!.docs[index].data());
                    return VStack([
                      Container(
                        height: MediaQuery.of(context).size.height * 0.13,
                        width: MediaQuery.of(context).size.width * 0.23,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                                image: NetworkImage(user.photoUrl),
                                fit: BoxFit.fill)),
                      ).pOnly(left: 10, right: 10),
                      user.username.text.bold
                          .minFontSize(10)
                          .maxFontSize(12)
                          .color(AppColors.whiteColor)
                          .make()
                          .pOnly(left: 30, top: 10)
                          .centered()
                    ]);
                  });
            } else {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: VStack([
                        Container(
                          height: MediaQuery.of(context).size.height * 0.13,
                          width: MediaQuery.of(context).size.width * 0.23,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors
                                .white, // Placeholder color while shimmering
                          ),
                        ).pOnly(left: 10, right: 10),
                        "UserName"
                            .text
                            .bold
                            .minFontSize(10)
                            .maxFontSize(12)
                            .color(AppColors.whiteColor)
                            .make()
                            .pOnly(left: 15, top: 10)
                            .centered(),
                      ]),
                    );
                  });
            }
          }),
    );
  }
}
