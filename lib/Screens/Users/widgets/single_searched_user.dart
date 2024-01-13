import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Constants/app_images.dart';
import 'package:snapflix/Screens/Chats/Message%20Section/message_screen.dart';
import 'package:snapflix/Screens/Profile/profile.dart';
import 'package:snapflix/Screens/Users/other_users_profile_screen.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/firebase_methods/firestore_helper.dart';
import 'package:snapflix/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SingleSearchedUser extends StatefulWidget {
  const SingleSearchedUser({super.key, required this.user});
  final UserModel user;

  @override
  State<SingleSearchedUser> createState() => _SingleSearchedUserState();
}

class _SingleSearchedUserState extends State<SingleSearchedUser> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navPush(
          context,
          OthersProfile(
            user: widget.user,
          )),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: AppColors.lightWhite,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(widget.user.photoUrl),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.user.username,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteColor),
                  ),
                  SvgPicture.asset(AppImages.blueTick)
                ],
              ),
              Text(
                '@${widget.user.username}',
                style: const TextStyle(color: AppColors.greColor, fontSize: 10),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: () {
                    FirestoreHelper().followUser(
                        FirebaseAuth.instance.currentUser!.uid,
                        widget.user.uid);
                    setState(() {});
                  },
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.pinkColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            widget.user.followers.contains(
                                    FirebaseAuth.instance.currentUser!.uid)
                                ? 'Following'
                                : 'Follow',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: AppColors.whiteColor, fontSize: 14)),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
