import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/models/post_model.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen({super.key, required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(post.postId)
              .collection('comments')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No comments yet'),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index].data();
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data['photoUrl']),
                      ),
                      title: Text(data['username']),
                      subtitle: Text(data['comment']),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.pinkColor,
                ),
              );
            }
          }),
    );
  }
}
