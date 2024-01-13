import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Constants/app_images.dart';
import 'package:snapflix/Screens/Chats/groups/create_group.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/models/user_model.dart';
import 'package:snapflix/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AddGroupParticipants extends StatelessWidget {
  AddGroupParticipants({super.key});

  List<String> selectedUsers = [];

  @override
  Widget build(BuildContext context) {
    selectedUsers.add(FirebaseAuth.instance.currentUser!.uid);
    var searchProvider = Provider.of<SearchProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.lightWhite,
        leading: IconButton(
          onPressed: () {
            navPop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: AppColors.whiteColor,
          ),
        ),
        title: searchProvider.isSearching
            ? TextFormField(
                decoration: const InputDecoration(hintText: 'Search users'),
                onChanged: (value) {
                  searchProvider.searchUser(value);
                },
              )
            : const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Group',
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Add Participants',
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
        actions: [
          IconButton(
              onPressed: () {
                searchProvider.changeSearchStatus();
              },
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(width: 1, color: AppColors.greColor)),
                    child: searchProvider.isSearching
                        ? const Icon(Icons.cancel, color: AppColors.whiteColor)
                        : SvgPicture.asset(AppImages.searchIcon)),
              )),
        ],
      ),
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Contacts',
                style: TextStyle(fontSize: 14, color: AppColors.whiteColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Image.asset('assets/images/user_plus.png'),
                  const Text(
                    'Contact',
                    style: TextStyle(fontSize: 14, color: AppColors.pinkColor),
                  ),
                ],
              ),
            ),
            StreamBuilder(
                stream: searchProvider.isSearching
                    ? FirebaseFirestore.instance
                        .collection('users')
                        .where('username',
                            isGreaterThanOrEqualTo: searchProvider.searchValue)
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('users')
                        .where('uid',
                            isNotEqualTo:
                                FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        primary: false,
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          UserModel user = UserModel.fromMap(
                              snapshot.data!.docs[index].data());
                          return SingleAddParticipants(
                            selectedUsers: selectedUsers,
                            user: user,
                          );
                        }));
                  } else {
                    return Shimmer.fromColors(
                        baseColor: AppColors.greColor,
                        highlightColor: AppColors.whiteColor,
                        child: ListView.builder(itemBuilder: (context, index) {
                          return ListTile(
                            leading: const CircleAvatar(
                              radius: 25,
                              backgroundColor: AppColors.greColor,
                            ),
                            title: Container(
                              height: 10,
                              width: 100,
                              color: AppColors.greColor,
                            ),
                            subtitle: Container(
                              height: 10,
                              width: 100,
                              color: AppColors.greColor,
                            ),
                          );
                        }));
                  }
                })
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          navPush(context, CreateGroup(selectedUsers: selectedUsers));
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.pinkColor,
                  borderRadius: BorderRadius.circular(8)),
              child: const Text(
                'Add Participants',
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}

class SingleAddParticipants extends StatefulWidget {
  SingleAddParticipants({
    super.key,
    required this.selectedUsers,
    required this.user,
  });

  final List<String> selectedUsers;
  final UserModel user;

  @override
  State<SingleAddParticipants> createState() => _SingleAddParticipantsState();
}

class _SingleAddParticipantsState extends State<SingleAddParticipants> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.selectedUsers.contains(widget.user.uid)) {
          widget.selectedUsers.remove(widget.user.uid);
          setState(() {
            isSelected = false;
          });
        } else {
          widget.selectedUsers.add(widget.user.uid);
          setState(() {
            isSelected = true;
          });
        }

        print(widget.selectedUsers);
      },
      child: ListTile(
        leading: Stack(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(widget.user.photoUrl),
                ),
                if (isSelected)
                  const Positioned(
                    top: 10,
                    bottom: 10,
                    left: 10,
                    child: Icon(
                      Icons.check,
                      color: AppColors.pinkColor,
                    ),
                  ),
              ],
            ),
            Positioned(
                left: 32,
                bottom: 2,
                child: SvgPicture.asset(AppImages.blueTick)),
          ],
        ),
        title: Text(
          widget.user.username,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.whiteColor),
        ),
        subtitle: const Text(
          'Hey there i\'m using chat companion',
          style: TextStyle(
              color: AppColors.greColor,
              fontSize: 10,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
