import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Constants/app_images.dart';
import 'package:snapflix/Custom%20Widgets/custom_button.dart';
import 'package:snapflix/Screens/Profile/widgets/chat_options.dart';
import 'package:snapflix/Screens/Profile/widgets/user_gallery_view.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/auth/Login/loginPage.dart';
import 'package:snapflix/models/user_model.dart';
import 'package:snapflix/providers/bottom_navigation.dart';
import 'package:snapflix/providers/stripe_controller.dart';
import 'package:snapflix/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context, listen: true).user;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return user == null
        ? const CircularProgressIndicator()
        : Scaffold(
            backgroundColor: AppColors.blackColor,
            appBar: AppBar(
              title: "Creator Information"
                  .text
                  .minFontSize(14)
                  .maxFontSize(16)
                  .color(AppColors.whiteColor)
                  .make(),
              centerTitle: true,
              backgroundColor: AppColors.lightWhite,
              automaticallyImplyLeading: false,
            ),
            body: VStack([
              VStack([
                CircleAvatar(
                  maxRadius: 50,
                  backgroundImage: NetworkImage(user.photoUrl),
                ).centered().pOnly(top: 10),
                HStack([
                  user.username.text.color(AppColors.whiteColor).make().pOnly(
                      top: 10, bottom: 10, left: width * 0.07, right: 10),
                  SvgPicture.asset(AppImages.blueTick)
                ]).centered(),
                "@${user.username}"
                    .text
                    .color(AppColors.lightText)
                    .make()
                    .centered(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Card(
                      elevation: 2,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 91,
                        child: Align(
                          alignment: Alignment.center,
                          child: VStack([
                            const Text(
                              'Account Balance:',
                              style: TextStyle(
                                color: AppColors.pinkColor,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const Text(
                              '220 Credits',
                              style: TextStyle(color: AppColors.blackColor),
                            ).pOnly(left: 20)
                          ]).centered().pOnly(
                              // top: height * 0.04,
                              // bottom: 20,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!.data();
                        return HStack([
                          VStack(alignment: MainAxisAlignment.center, [
                            "${data!['followers'].length}"
                                .text
                                .bold
                                .minFontSize(20)
                                .maxFontSize(22)
                                .color(AppColors.whiteColor)
                                .make()
                                .pOnly(left: 30),
                            "Followers"
                                .text
                                .minFontSize(15)
                                .maxFontSize(16)
                                .color(AppColors.lightText)
                                .make(),
                          ]).pOnly(right: width * 0.07),
                          VStack(alignment: MainAxisAlignment.center, [
                            "${data['following'].length}"
                                .text
                                .bold
                                .minFontSize(20)
                                .maxFontSize(22)
                                .color(AppColors.whiteColor)
                                .make()
                                .pOnly(left: 30),
                            "Following"
                                .text
                                .minFontSize(15)
                                .maxFontSize(16)
                                .color(AppColors.lightText)
                                .make(),
                          ]).pOnly(right: width * 0.07),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('posts')
                                  .where('uid', isEqualTo: user.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  int likes = 0;
                                  for (int i = 0;
                                      i < snapshot.data!.docs.length;
                                      i++) {
                                    var data = snapshot.data!.docs[i].data();
                                    likes += data['likes'].length as int;
                                  }
                                  return VStack(
                                      alignment: MainAxisAlignment.center,
                                      [
                                        "    $likes"
                                            .text
                                            .bold
                                            .minFontSize(20)
                                            .maxFontSize(22)
                                            .color(AppColors.whiteColor)
                                            .make(),
                                        "Likes"
                                            .text
                                            .minFontSize(15)
                                            .maxFontSize(16)
                                            .color(AppColors.lightText)
                                            .make()
                                            .pOnly(left: 10)
                                      ]).pOnly();
                                } else {
                                  return Shimmer.fromColors(
                                      baseColor: AppColors.greColor,
                                      highlightColor: AppColors.whiteColor,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 20,
                                            color: AppColors.whiteColor,
                                          ),
                                          Container(
                                            height: 20,
                                            width: 20,
                                            color: AppColors.whiteColor,
                                          ),
                                        ],
                                      ));
                                }
                              }),
                        ]).pOnly(top: height * 0.03, bottom: 10).centered();
                      } else {
                        return Shimmer.fromColors(
                            baseColor: AppColors.greColor,
                            highlightColor: AppColors.whiteColor,
                            child: Column(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  color: AppColors.whiteColor,
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  color: AppColors.whiteColor,
                                ),
                              ],
                            ));
                      }
                    }),
                HStack(alignment: MainAxisAlignment.center, [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 20),
                    child: Container(
                      // height: height * 0.002,

                      decoration: BoxDecoration(
                          color: AppColors.pinkColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 19, vertical: 14),
                        child: Text(
                          'Follow',
                          style: TextStyle(color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                  ),
                  // customButton(context,
                  //     title: "Follow",
                  //     titleColor: AppColors.whiteColor,
                  //     buttonColor: AppColors.pinkColor, onTapedFunc: () {
                  //   if (user.followers.contains(user.uid)) {}
                  // }).box.rounded.make().pOnly(left: 50, right: 50),
                  InkWell(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      GoogleSignIn().signOut();

                      navReplace(
                        context,
                        const LoginPage(),
                      );
                      Provider.of<BottomNavigationProvider>(context,
                              listen: false)
                          .setCurrentIndex = 2;
                    },
                    child: Container(
                      // height: height * 0.002,

                      decoration: BoxDecoration(
                          color: AppColors.lightWhite,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 19, vertical: 14),
                        child: Text(
                          'Logout',
                          style: TextStyle(color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                  ),
                ]).pOnly(bottom: 10),
                // customButton(context,
                //     title: "Add Post",
                //     titleColor: AppColors.whiteColor,
                //     buttonColor: AppColors.pinkColor, onTapedFunc: () {
                //   navPush(context, AddPostScreen());
                // }).box.rounded.make().pOnly(left: 10, right: 10),
              ]).box.color(AppColors.lightWhite).rounded.make().pOnly(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 20,
                  ),
              VStack([
                "Let's Chat".text.color(AppColors.whiteColor).bold.make().p(20),
                //chat options
                const ChatListOptions().pOnly(left: 10, right: 10, bottom: 10)
              ]).box.color(AppColors.lightWhite).rounded.make().pOnly(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 20,
                  ),
              HStack(spacing: width * 0.42, [
                "Payment Section"
                    .text
                    .bold
                    .color(AppColors.whiteColor)
                    .make()
                    .p16(),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.whiteColor,
                ).pOnly(right: 10),
              ])
                  .box
                  .rounded
                  .color(AppColors.lightWhite)
                  .make()
                  .pOnly(left: 10, right: 10, bottom: 10)
                  .onTap(() {
                // Provider.of<PaymentController>(context, listen: false)
                //     .createPaymentIntent('50', 'usd');
              }),
              VStack([
                "User's Gallery"
                    .text
                    .color(AppColors.whiteColor)
                    .bold
                    .make()
                    .p(20),
                //Galery view
                UserGalleryView(
                  user: user,
                ).pOnly(left: 10, right: 10, bottom: 20),
                customButton(context,
                        titleColor: AppColors.pinkColor,
                        title: "Expore More",
                        buttonColor: AppColors.transparentColor,
                        onTapedFunc: () {})
                    .box
                    .border(color: AppColors.lightWhite)
                    .make()
                    .pOnly(bottom: 10, left: 10, right: 10)
              ]).box.color(AppColors.lightWhite).rounded.make().pOnly(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 20,
                  ),
              VStack([
                "My Links".text.color(AppColors.whiteColor).bold.make().p(20),
                VStack([
                  HStack([
                    SvgPicture.asset(AppImages.twitterLogo)
                        .pOnly(left: width * 0.17),
                    "@shahzaibjugwa"
                        .text
                        .color(AppColors.lightText)
                        .make()
                        .pOnly(left: width * 0.09)
                        .centered()
                  ]).pOnly(bottom: 20),
                  HStack([
                    Image.asset(AppImages.facebookLogo)
                        .box
                        .height(height * 0.035)
                        .make()
                        .pOnly(left: width * 0.17),
                    "shahzaib Ahmad"
                        .text
                        .color(AppColors.lightText)
                        .make()
                        .pOnly(left: width * 0.09)
                        .centered()
                  ]).pOnly(bottom: 20),
                  HStack([
                    SvgPicture.asset(AppImages.instaLogo)
                        .pOnly(left: width * 0.17),
                    "shahzaib jugwal"
                        .text
                        .color(AppColors.lightText)
                        .make()
                        .pOnly(left: width * 0.09)
                        .centered()
                  ]).pOnly(bottom: 20),
                  HStack([
                    SvgPicture.asset(AppImages.youtubeLogo)
                        .pOnly(left: width * 0.17),
                    "shahzaibjugwal"
                        .text
                        .color(AppColors.lightText)
                        .make()
                        .pOnly(left: width * 0.09)
                        .centered()
                  ]).pOnly(bottom: 20)
                ])
              ])
                  .box
                  .width(width)
                  .color(AppColors.lightWhite)
                  .rounded
                  .make()
                  .pOnly(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 20,
                  ),
              VStack([
                "Tags".text.color(AppColors.whiteColor).bold.make().p(20),
                HStack([
                  HStack([
                    SvgPicture.asset(AppImages.searchIcon)
                        .pOnly(left: 10, top: 10, bottom: 10),
                    "Love"
                        .text
                        .color(AppColors.lightText)
                        .make()
                        .p(10)
                        .centered()
                  ])
                      .box
                      .rounded
                      .border(color: AppColors.lightWhite)
                      .make()
                      .pOnly(bottom: height * 0.05, left: width * 0.05),
                  HStack([
                    SvgPicture.asset(AppImages.searchIcon)
                        .pOnly(left: 10, top: 10, bottom: 10),
                    "Romantic"
                        .text
                        .color(AppColors.lightText)
                        .make()
                        .p(10)
                        .centered()
                  ])
                      .box
                      .rounded
                      .border(color: AppColors.lightWhite)
                      .make()
                      .pOnly(bottom: height * 0.05, left: width * 0.05),
                ]),
                HStack([
                  HStack([
                    SvgPicture.asset(AppImages.searchIcon)
                        .pOnly(left: 10, top: 10, bottom: 10),
                    "Songs"
                        .text
                        .color(AppColors.lightText)
                        .make()
                        .p(10)
                        .centered()
                  ])
                      .box
                      .rounded
                      .border(color: AppColors.lightWhite)
                      .make()
                      .pOnly(bottom: height * 0.05, left: width * 0.05),
                  HStack([
                    SvgPicture.asset(AppImages.searchIcon)
                        .pOnly(left: 10, top: 10, bottom: 10),
                    "Hate"
                        .text
                        .color(AppColors.lightText)
                        .make()
                        .p(10)
                        .centered()
                  ])
                      .box
                      .rounded
                      .border(color: AppColors.lightWhite)
                      .make()
                      .pOnly(bottom: height * 0.05, left: width * 0.05),
                  HStack([
                    SvgPicture.asset(AppImages.searchIcon)
                        .pOnly(left: 10, top: 10, bottom: 10),
                    "Like"
                        .text
                        .color(AppColors.lightText)
                        .make()
                        .p(10)
                        .centered()
                  ])
                      .box
                      .rounded
                      .border(color: AppColors.lightWhite)
                      .make()
                      .pOnly(bottom: height * 0.05, left: width * 0.05),
                ])
              ])
                  .box
                  .width(width)
                  .color(AppColors.lightWhite)
                  .rounded
                  .make()
                  .pOnly(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 20,
                  ),
            ]).scrollVertical(),
          );
  }
}
