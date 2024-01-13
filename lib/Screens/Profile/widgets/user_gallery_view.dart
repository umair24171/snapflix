import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snapflix/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserGalleryView extends StatelessWidget {
  const UserGalleryView({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('postType', isNotEqualTo: 'video')
              .where('uid', isEqualTo: user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 100,
                    childAspectRatio: 50,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(snapshot.data!.docs[index]
                                  .data()['imageUrl']),
                              fit: BoxFit.cover)),
                    );
                  });
            } else {
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 100,
                    childAspectRatio: 50,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 6,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors
                              .white, // Set background color for the shimmer
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
