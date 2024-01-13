import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Custom%20Widgets/custom_searchBar.dart';
import 'package:snapflix/Screens/Users/widgets/single_searched_user.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/models/user_model.dart';
import 'package:snapflix/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class UsersSearchScreen extends StatefulWidget {
  const UsersSearchScreen({super.key});

  @override
  State<UsersSearchScreen> createState() => _UsersSearchScreenState();
}

class _UsersSearchScreenState extends State<UsersSearchScreen> {
  Size get preferredSize => const Size.fromHeight(160);

  String searchValue = "";

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchProvider>(context);
    return Scaffold(
        backgroundColor: AppColors.blackColor,
        appBar: AppBar(
            toolbarHeight: preferredSize.height,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.lightWhite,
            title: VStack([
              HStack([
                IconButton(
                    onPressed: () {
                      navPop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.whiteColor,
                      size: 18,
                    )).pOnly(left: 10),
                (/* "$userName 👋"  */ "User")
                    .text
                    .align(TextAlign.center)
                    .minFontSize(12)
                    .maxFontSize(18)
                    .color(AppColors.whiteColor)
                    .make()
                    .pOnly(
                      left: MediaQuery.of(context).size.width * 0.25,
                    ),
              ]),
              customSearchBar(() {
                navPush(
                  context,
                  const UsersSearchScreen(),
                );
              }, (value) {
                if (value.isNotEmpty) {
                  provider.setSeachingUser(true);
                  provider.searchedUsers.clear();
                  for (var i in provider.users) {
                    if (i.username
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                        i.email.toLowerCase().contains(value.toLowerCase())) {
                      provider.searchedUsers.add(i);
                    }
                  }
                } else {
                  provider.setSeachingUser(false);
                  provider.searchedUsers.clear();
                }
              }),
            ])),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No users found"),
                  );
                }
                var data = snapshot.data?.docs;
                provider.users =
                    data?.map((e) => UserModel.fromMap(e.data())).toList() ??
                        [];
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: provider.isSearhingUser
                      ? provider.searchedUsers.length
                      : provider.users.length,
                  itemBuilder: (context, index) {
                    return SingleSearchedUser(
                      user: provider.isSearhingUser
                          ? provider.searchedUsers[index]
                          : UserModel.fromMap(
                              snapshot.data!.docs[index].data()),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.pinkColor,
                  ),
                );
              }
            }));
  }
}
