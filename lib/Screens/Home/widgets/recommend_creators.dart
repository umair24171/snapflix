import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Constants/app_images.dart';
import 'package:snapflix/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

class RecommendedCreators extends StatelessWidget {
  const RecommendedCreators({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').get(),
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
                          .pOnly(left: 27, top: 10)
                          .centered()
                    ]);
                  });
            } else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.13,
                      width: MediaQuery.of(context).size.width * 0.23,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors
                            .grey[300], // Set background color for the shimmer
                      ),
                      child: VStack([
                        Container(
                          // height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors
                                .white, // Set background color for the shimmer
                          ),
                        ).pOnly(left: 10, right: 10),
                        "UserName"
                            .text
                            .bold
                            .minFontSize(10)
                            .maxFontSize(12)
                            .color(Colors.white)
                            .make()
                            .pOnly(left: 15, top: 10)
                            .centered(),
                      ]),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
