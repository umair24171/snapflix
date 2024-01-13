// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Screens/Chats/groups/all_groups_screen.dart';
import 'package:snapflix/Utils/additional_methods.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/firebase_methods/firestore_helper.dart';
import 'package:snapflix/firebase_methods/group_methods.dart';
import 'package:snapflix/models/group_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateGroup extends StatefulWidget {
  CreateGroup({super.key, required this.selectedUsers});

  List<String> selectedUsers;

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  File? pickedCoverImage;
  File? groupImage;
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _groupDescriptionController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(widget.selectedUsers);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                InkWell(
                  onTap: () async {
                    pickedCoverImage = await FirestoreHelper().pickImage();
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 14.0, right: 14.0, bottom: 40.0, top: 16.0),
                    child: Center(
                      child: SizedBox(
                        height: 180,
                        width: 400,
                        child: pickedCoverImage == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png', // Replace with your image URL
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.file(
                                  pickedCoverImage!, // Replace with your image URL
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 100.0), // Adjust the margin as needed
                      width: 100.0,
                      height: 100.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: groupImage == null
                          ? ClipOval(
                              child: Image.network(
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png', // Replace with your image URL
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipOval(
                              child: Image.file(
                                groupImage!, // Replace with your image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Positioned(
                        top: 150,
                        left: 60,
                        child: IconButton(
                          onPressed: () async {
                            groupImage = await FirestoreHelper().pickImage();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: AppColors.blackColor,
                            size: 35,
                          ),
                        ))
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(
                'Group title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                controller: _groupNameController,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'title..',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(
                'Add Group Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                controller: _groupDescriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Description..',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () async {
          if (groupImage == null ||
              pickedCoverImage == null ||
              _groupNameController.text.isEmpty) {
            showSnackBar(
              'Error',
              'Please fill all fields and pick images',
            );
          } else {
            String groupId = const Uuid().v4();
            String groupImageUrl = await FirestoreHelper()
                .uploadFile('group_images', groupImage!, context);
            String coverImageUrl = await FirestoreHelper()
                .uploadFile('group_images', pickedCoverImage!, context);

            GroupModel groupModel = GroupModel(
                name: _groupNameController.text,
                description: _groupDescriptionController.text,
                image: groupImageUrl,
                coverImage: coverImageUrl,
                id: groupId,
                adminId: FirebaseAuth.instance.currentUser!.uid,
                members: widget.selectedUsers,
                createdAt: DateTime.now(),
                sendMessageStatus: false,
                editGroupSettings: false);
            GroupMethods().createGroup(groupModel, groupId);
            showSnackBar('Successful', 'Group created successfully');
            navReplace(context, const AllGroupsScreen());
          }
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
                'Create Group',
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
