import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Constants/app_images.dart';
// import 'package:snapflix/Constants/app_images.dart';
import 'package:snapflix/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';

class FeaturedContent extends StatelessWidget {
  const FeaturedContent({super.key});

  // late VideoPlayerController _videoPlayerController;
  // List<PostModel> posts = [];

  // @override
  // void initState() {
  //   super.initState();
  //   getVideos();
  //   _videoPlayerController =
  //       VideoPlayerController.networkUrl(Uri.parse(posts.first.imageUrl))
  //         ..initialize().then((_) {
  //           // Ensure the first frame is shown after the video is initialized
  //           setState(() {});
  //         });

  //   _videoPlayerController.setVolume(1);
  //   _videoPlayerController.seekTo(const Duration(seconds: 0));
  // }

  // getVideos() async {
  //   QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
  //       .instance
  //       .collection('posts')
  //       .where('postType', isEqualTo: 'video')
  //       .get();
  //   posts = snapshot.docs.map((e) => PostModel.fromMap(e.data())).toList();
  //   setState(() {});
  // }

  // @override
  // void dispose() {
  //   // Ensure you dispose of the video controller when the widget is disposed
  //   _videoPlayerController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return VStack([
      HStack(spacing: MediaQuery.of(context).size.width * 0.3, [
        "Featured Content"
            .text
            .bold
            .maxFontSize(19)
            .minFontSize(17)
            .color(AppColors.whiteColor)
            .make(),
        // TextButton(
        //     onPressed: () {},
        //     child: "View all".text.underline.color(AppColors.lightText).make())
      ]).pOnly(left: 10, top: 20, bottom: 20),
      SizedBox(
        height: height * 0.3,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .where('postType', isEqualTo: 'video')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    PostModel post =
                        PostModel.fromMap(snapshot.data!.docs[index].data());
                    return VStack([
                      TrendingReels(
                        height: height,
                        width: width,
                        postModel: post,
                      ).p(10),
                      post.caption.text
                          .maxLines(1)
                          .ellipsis
                          .maxFontSize(12)
                          .minFontSize(10)
                          .fontWeight(FontWeight.w300)
                          .color(AppColors.whiteColor)
                          .make()
                          .pOnly(left: 10),
                      HStack([
                        "Trending hit Reel"
                            .text
                            .maxLines(1)
                            .ellipsis
                            .maxFontSize(12)
                            .minFontSize(10)
                            .fontWeight(FontWeight.w300)
                            .color(AppColors.lightText)
                            .make()
                            .pOnly(left: 10),
                        // const Icon(
                        //   Icons.star,
                        //   color: AppColors.starYellow,
                        //   size: 20,
                        // ).pOnly(left: 10),
                        // const Icon(
                        //   Icons.star,
                        //   color: AppColors.starYellow,
                        //   size: 20,
                        // ),
                        // const Icon(
                        //   Icons.star,
                        //   color: AppColors.starYellow,
                        //   size: 20,
                        // )
                      ])
                    ])
                        .box
                        .rounded
                        .color(AppColors.lightWhite)
                        .make()
                        .pOnly(left: 10, right: 10);
                  },
                );
              } else {
                return ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
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
      )
    ]);
  }
}

class TrendingReels extends StatefulWidget {
  const TrendingReels(
      {super.key,
      required this.height,
      required this.width,
      required this.postModel});

  final double height;
  final double width;
  final PostModel postModel;

  @override
  State<TrendingReels> createState() => _TrendingReelsState();
}

class _TrendingReelsState extends State<TrendingReels> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.postModel.imageUrl))
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized
            setState(() {});
          });

    _videoPlayerController.setVolume(1);
    _videoPlayerController.seekTo(const Duration(seconds: 0));
  }

  @override
  void dispose() {
    // Ensure you dispose of the video controller when the widget is disposed
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 0.2,
      width: widget.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
          onTap: () {
            if (_videoPlayerController.value.isPlaying) {
              _videoPlayerController.pause();
            } else {
              _videoPlayerController.play();
            }
          },
          child: VideoPlayer(_videoPlayerController)),
      //  IconButton(
      //   onPressed: () {},
      //   icon: const Icon(
      //     Icons.play_arrow,
      //     color: AppColors.whiteColor,
      //     size: 30,
      //   )
      //       .box
      //       .roundedFull
      //       .border(color: AppColors.whiteColor)
      //       .color(AppColors.blackColor)
      //       .make(),
      // ),
    );
  }
}
