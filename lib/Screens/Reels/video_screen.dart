import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Screens/Reels/add_reels_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:snapflix/Screens/Reels/video_comment_screen.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({Key? key}) : super(key: key);

  final FirebaseAuth auth = FirebaseAuth.instance;

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(children: [
        Positioned(
          left: 5,
          child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ]),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(11),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    );
  }

  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: preferredSize.height,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.blackColor,
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
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PageView.builder(
                  itemCount: snapshot.data!.docs.length,
                  controller:
                      PageController(initialPage: 0, viewportFraction: 1),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    PostModel post =
                        PostModel.fromMap(snapshot.data!.docs[index].data());
                    return Stack(
                      children: [
                        VideoPlayerItem(
                          videoUrl: post.imageUrl,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            post.username,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            post.caption,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.music_note,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                'No song',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin:
                                        EdgeInsets.only(top: size.height / 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        buildProfile(
                                          post.photoUrl,
                                        ),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (post.likes.contains(
                                                    auth.currentUser!.uid)) {
                                                  post.likes.remove(
                                                      auth.currentUser!.uid);
                                                } else {
                                                  post.likes.add(
                                                      auth.currentUser!.uid);
                                                }
                                                FirebaseFirestore.instance
                                                    .collection('posts')
                                                    .doc(post.postId)
                                                    .update({
                                                  'likes': post.likes,
                                                });
                                                // setState(() {});
                                              },
                                              child: Icon(
                                                Icons.favorite,
                                                size: 40,
                                                color: post.likes.contains(
                                                        auth.currentUser!.uid)
                                                    ? Colors.red
                                                    : Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              post.likes.length.toString(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () =>
                                                  Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CommentScreen(post: post),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.comment,
                                                size: 40,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              post.comments.length.toString(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: const Icon(
                                                Icons.reply,
                                                size: 40,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 7),
                                            const Text(
                                              '0',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                        CircleAnimation(
                                          child: buildMusicAlbum(post.photoUrl),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              } else {
                return const LinearProgressIndicator();
              }
            }));
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        videoPlayerController.play();
        videoPlayerController.setVolume(1);
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: VideoPlayer(videoPlayerController),
    );
  }
}

class CircleAnimation extends StatefulWidget {
  final Widget child;
  const CircleAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _CircleAnimationState createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 5000,
      ),
    );
    controller.forward();
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: widget.child,
    );
  }
}
