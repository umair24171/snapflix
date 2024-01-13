import 'dart:io';

import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/firebase_methods/firestore_helper.dart';
import 'package:snapflix/models/post_model.dart';
import 'package:snapflix/models/user_model.dart';
import 'package:snapflix/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddPostScreen extends StatefulWidget {
  AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? pickedFile;
  final TextEditingController bioController = TextEditingController();
  final List<String> categories = [
    'all'
        'politics',
    'sports',
    'entertainment',
    'technology',
    'fashion',
    'food',
    'travel',
    'health',
  ];
  String selectedCategory = 'all';

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.lightWhite,
        title: const Text(
          'Create a Post',
          style: TextStyle(color: AppColors.whiteColor, fontSize: 16),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.cancel_outlined,
              color: AppColors.whiteColor,
            )),
        actions: [
          TextButton(
            onPressed: () async {
              String postId = const Uuid().v4();
              String imageUrl = await FirestoreHelper()
                  .uploadFile('posts', pickedFile!, context);
              PostModel post = PostModel(
                  thumbnailUrl: '',
                  username: user!.username,
                  postType: PostType.image,
                  caption: bioController.text,
                  imageUrl: imageUrl,
                  photoUrl: user.photoUrl,
                  uid: user.uid,
                  postId: postId,
                  category: selectedCategory,
                  publishedDate: DateTime.now(),
                  likes: [],
                  comments: []);
              FirestoreHelper().addPost(post);
              Navigator.pop(context);
            },
            child: const Text(
              'Post',
              style: TextStyle(color: AppColors.pinkColor, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextFormField(
          //     style: TextStyle(color: AppColors.whiteColor),
          //     decoration: InputDecoration(
          //       enabled: true,
          //       hintText: 'Title',
          //       hintStyle: const TextStyle(color: AppColors.lightText),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10),
          //         borderSide: const BorderSide(color: AppColors.lightWhite),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: bioController,
              style: const TextStyle(color: AppColors.whiteColor),
              maxLines: 3,
              decoration: InputDecoration(
                enabled: true,
                hintText: 'Post Description',
                hintStyle: const TextStyle(color: AppColors.lightText),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.lightWhite),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Choose Category',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
                DropdownButton(
                    focusColor: AppColors.whiteColor,
                    style: const TextStyle(color: AppColors.whiteColor),
                    items: categories
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style:
                                  const TextStyle(color: AppColors.blackColor),
                            )))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                pickedFile = await FirestoreHelper().pickImage();
                setState(() {});
              },
              child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.whiteColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: pickedFile == null
                      ? IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_a_photo_outlined))
                      : Image.file(
                          pickedFile!,
                          fit: BoxFit.cover,
                          height: 300,
                        )),
            ),
          )
        ],
      ),
    );
  }
}
