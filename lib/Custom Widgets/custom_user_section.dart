import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Custom%20Widgets/custom_searchBar.dart';
import 'package:snapflix/Screens/Users/users_search_screen.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/models/user_model.dart';
import 'package:snapflix/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customUserSection(
  context, {
  String? userImageUrl,
  String? userName,
  /* when we call api we use these variables */
}) {
  UserModel? user = Provider.of<UserProvider>(context).user;
  return user == null
      ? const CircularProgressIndicator()
      : VStack([
          HStack([
            CircleAvatar(
              foregroundImage: NetworkImage(userImageUrl ?? ""),
              backgroundImage: NetworkImage(user.photoUrl),
              backgroundColor: AppColors.whiteColor,
              maxRadius: 30,
            ).pOnly(top: 20, bottom: 10),
            VStack([
              "Welcome!"
                  .text
                  .minFontSize(12)
                  .maxFontSize(14)
                  .color(AppColors.lightText)
                  .make()
                  .pOnly(left: 10),
              (/* "$userName 👋"  */ "${user.username} 👋")
                  .text
                  .minFontSize(12)
                  .maxFontSize(14)
                  .color(AppColors.whiteColor)
                  .make()
                  .pOnly(left: 10, top: 10),
            ]),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_on_outlined,
                  color: AppColors.whiteColor,
                  size: 30,
                )).pOnly(left: MediaQuery.of(context).size.width * 0.32),
          ]),
          customSearchBar(() {
            navPush(context, const UsersSearchScreen());
          }, (value) {}),
        ]);
}
