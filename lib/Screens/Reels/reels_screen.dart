import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Screens/Reels/add_reels_screen.dart';
import 'package:snapflix/Screens/Reels/widgets/reels_list.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Reels extends StatelessWidget {
  const Reels({super.key});
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    // var user = Provider.of<UserProvider>(
    //   context,
    // ).user;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
          toolbarHeight: preferredSize.height,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.lightWhite,
          //User Section
          title: VStack([
            // customSearchBar(() {
            //   navPush(context, const UsersSearchScreen());
            // }, (value) {}),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  navPush(context, const AddVideoScreen());
                },
                icon: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        // color: AppColors.pinkColor,
                        // border:
                        //     Border.all(color: AppColors.whiteColor, width: 1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text('Create Reel',
                        //     style: TextStyle(
                        //         color: AppColors.whiteColor,
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w400)),
                        // SizedBox(
                        //   width: 5,
                        // ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_circle_outline_rounded,
                              color: AppColors.whiteColor,
                              size: 35,
                            ))
                        // Image.asset(
                        //   'assets/images/up-loading.png',
                        //   fit: BoxFit.cover,
                        //   height: 35,
                        // )
                      ],
                    )),
              ),
            ),
          ])),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('postType', isEqualTo: 'video')
              .orderBy('publishedDate', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No posts yet"),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    List likes = snapshot.data!.docs[index].data()['likes'];
                    PostModel post =
                        PostModel.fromMap(snapshot.data!.docs[index].data());
                    return ReelsListView(
                      post: post,
                      likes: likes,
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
