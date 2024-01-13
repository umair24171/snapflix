import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Screens/Chats/Message%20Section/message_screen.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/models/group_model.dart';
import 'package:flutter/material.dart';

class AllGroupsScreen extends StatelessWidget {
  const AllGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.lightWhite,
        title: const Text(
          'Groups',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        leading: IconButton(
            onPressed: () {
              navPop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.whiteColor,
            )),
        actions: [
          IconButton(
              onPressed: () {
                navPush(context, MessageScreen());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('groups')
                .where('members',
                    arrayContains: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No groups'),
                  );
                }
                var data = snapshot.data!.docs;
                var groupModel =
                    data.map((e) => GroupModel.fromMap(e.data())).toList();
                return ListView.builder(
                    itemCount: groupModel.length,
                    itemBuilder: (context, index) {
                      // Map<String, dynamic> ds = snapshot.data!.docs[index].data();
                      // GroupModel groupModel = GroupModel.fromMap(ds);
                      return InkWell(
                        onTap: () {
                          navPush(
                              context,
                              MessageScreen(
                                groupModel: groupModel[index],
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  NetworkImage(groupModel[index].image),
                            ),
                            title: Text(
                              groupModel[index].name,
                              style: TextStyle(color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
