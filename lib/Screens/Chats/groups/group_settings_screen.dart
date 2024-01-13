import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Screens/Chats/groups/add_participants_screen.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/models/group_model.dart';
import 'package:snapflix/models/user_model.dart';
import 'package:snapflix/providers/group_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupSettingsScreen extends StatefulWidget {
  GroupSettingsScreen({super.key, required this.groupModel});
  GroupModel groupModel;

  @override
  State<GroupSettingsScreen> createState() => _GroupSettingsScreenState();
}

class _GroupSettingsScreenState extends State<GroupSettingsScreen> {
  bool isswitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Group Info',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        leading: InkWell(
          onTap: () {
            navPop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey, // Change the color as needed
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14.0, right: 14.0, bottom: 40.0, top: 16.0),
                  child: Center(
                    child: SizedBox(
                      height: 180,
                      width: 400,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          widget.groupModel.coverImage == ''
                              ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
                              : widget.groupModel
                                  .coverImage, // Replace with your image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 100.0), // Adjust the margin as needed
                  width: 100.0,
                  height: 100.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.network(
                      widget.groupModel.image, // Replace with your image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'Boys for Life',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Text(
              '${widget.groupModel.members.length} Members',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Group Description',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            'Group Description',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          'Only admin can edits',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Notifications',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: Colors.orange,
                        size: 35,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Mute Notifications',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: isswitched,
                    onChanged: ((value) {
                      setState(
                        () {
                          isswitched = value;
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            if (widget.groupModel.adminId ==
                FirebaseAuth.instance.currentUser!.uid)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Participants Settings',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            if (widget.groupModel.adminId ==
                FirebaseAuth.instance.currentUser!.uid)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.notifications,
                          color: Colors.orange,
                          size: 35,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Send Messages',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Consumer<GroupProvider>(
                      builder: (context, value, child) => Switch(
                        value: value.initialStatus,
                        onChanged: ((value1) {
                          value.updateGroupSendMessageStatus(
                              widget.groupModel, value1);
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Participants',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  navPush(
                    context,
                    AddGroupParticipants(),
                  );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.person_add_alt,
                      color: Colors.orange,
                      size: 35,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Add Participants',
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('uid', whereIn: widget.groupModel.members)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!.docs;
                    var userModel =
                        data.map((e) => UserModel.fromMap(e.data())).toList();
                    return ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        primary: false,
                        shrinkWrap: true,
                        itemCount: userModel.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    NetworkImage(userModel[index].photoUrl),
                              ),
                              title: Text(
                                userModel[index].username,
                                style: const TextStyle(
                                    color: AppColors.whiteColor),
                              ),
                              trailing: userModel[index].uid ==
                                      widget.groupModel.adminId
                                  ? const Text(
                                      'admin',
                                      style: TextStyle(
                                          color: AppColors.whiteColor),
                                    )
                                  : Text(''));
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
