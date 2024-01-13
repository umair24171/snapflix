// ignore_for_file: unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tago;
import 'package:uuid/uuid.dart';

class CommentScreen extends StatelessWidget {
  final PostModel post;
  CommentScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // commentController.updatePostId(id);

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .doc(post.postId)
                          .collection('comments')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final data = snapshot.data!.docs[index].data();
                                // final comment = commentController.comments[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    backgroundImage:
                                        NetworkImage(data['photoUrl']),
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        "${data['username']}  ",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: AppColors.pinkColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        data['comment'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        tago.format(
                                          (data['publishedDate']).toDate(),
                                        ),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        '0 likes',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  trailing: InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.favorite,
                                      size: 25,
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return const LinearProgressIndicator();
                        }
                      })),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.lightText,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.pinkColor,
                      ),
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    String commentId = const Uuid().v4();
                    FirebaseFirestore.instance
                        .collection('posts')
                        .doc(post.postId)
                        .collection('comments')
                        .doc(commentId)
                        .set({
                      'comment': _commentController.text,
                      'username': post.username,
                      'photoUrl': post.photoUrl,
                      'publishedDate': DateTime.now(),
                      'userId': FirebaseAuth.instance.currentUser!.uid,
                      'postId': post.postId,
                      'commendId': commentId,
                    });
                    _commentController.clear();
                  },
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
