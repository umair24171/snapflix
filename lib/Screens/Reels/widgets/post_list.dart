import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Constants/app_images.dart';
import 'package:snapflix/Screens/Reels/comments_screen.dart';
import 'package:snapflix/Utils/additional_methods.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/models/post_model.dart';
import 'package:snapflix/models/user_model.dart';
import 'package:snapflix/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';

class PostList extends StatefulWidget {
  const PostList({super.key, required this.post, required this.likes});
  final List likes;
  final PostModel post;

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context).user;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
          child: VStack([
        HStack(spacing: width * 0.23, [
          HStack([
            CircleAvatar(
              foregroundImage: const NetworkImage(""),
              backgroundImage: NetworkImage(widget.post.photoUrl),
            ).pOnly(left: 10, top: 10, bottom: 5),
            VStack([
              widget.post.username.text
                  .color(AppColors.whiteColor)
                  .make()
                  .pOnly(left: 10),
              "${widget.post.publishedDate.day} hour ago"
                  .text
                  .color(AppColors.lightText)
                  .make()
                  .pOnly(left: 5),
            ]),
            SvgPicture.asset(AppImages.blueTick).pOnly(
              left: 10,
            )
          ]),
          PopupMenuButton(
              itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'Delete',
                      child: Text(
                        'Delete',
                        style: TextStyle(color: AppColors.blackColor),
                      ),
                    )
                  ],
              icon: const Icon(
                Icons.more_horiz,
                color: AppColors.whiteColor,
              ),
              onSelected: (value) {
                if (value == 'Delete') {
                  if (user!.uid == widget.post.uid) {
                    FirebaseFirestore.instance
                        .collection('posts')
                        .doc(widget.post.postId)
                        .delete();
                  } else {
                    showSnackBar('Warning', 'You can not delete this post');
                  }
                }
              }),
          // IconButton(
          //   onPressed: () {

          //   },
          //   icon: const Icon(
          //     Icons.more_horiz,
          //     color: AppColors.whiteColor,
          //   ),
          // ),
        ]),
        Container(
            height: height * 0.25,
            width: width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              widget.post.imageUrl,
              fit: BoxFit.cover,
            )).pOnly(left: 10, right: 10, top: 10),
        HStack([
          SvgPicture.asset(AppImages.likeIcon).onTap(() {
            if (widget.post.likes.contains(user!.uid)) {
              widget.post.likes.remove(user.uid);
            } else {
              widget.post.likes.add(user.uid);
            }
            FirebaseFirestore.instance
                .collection('posts')
                .doc(widget.post.postId)
                .update({
              'likes': widget.post.likes,
            });
            setState(() {});
          }).pOnly(left: 10, top: 10, bottom: 10),
          SvgPicture.asset(AppImages.commentIcon).onTap(() {
            navPush(context, CommentsScreen(post: widget.post));
          }).pOnly(left: 10, top: 10, bottom: 10),
          SvgPicture.asset(AppImages.shareIcon)
              .onTap(() {})
              .pOnly(left: 10, top: 10, bottom: 10),
          SvgPicture.asset(AppImages.commentRowIcon)
              .onTap(() {})
              .pOnly(left: width * 0.55),
        ]),
        "${widget.likes.length} Likes"
            .text
            .bold
            .maxLines(1)
            .ellipsis
            .maxFontSize(12)
            .minFontSize(10)
            .color(AppColors.whiteColor)
            .make()
            .pOnly(left: 10),
        "Also liked by your firnd and others"
            .text
            .maxLines(1)
            .ellipsis
            .maxFontSize(12)
            .minFontSize(10)
            .fontWeight(FontWeight.w300)
            .color(AppColors.whiteColor)
            .make()
            .pOnly(left: 10),
        HStack([
          widget.post.caption.text
              .maxLines(1)
              .ellipsis
              .maxFontSize(12)
              .minFontSize(10)
              .fontWeight(FontWeight.w300)
              .color(AppColors.lightText)
              .make()
              .pOnly(
                left: 10,
              ),
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
        ]),
        TextFormField(
          onFieldSubmitted: (value) {
            String commentId = const Uuid().v4();
            FirebaseFirestore.instance
                .collection('posts')
                .doc(widget.post.postId)
                .collection('comments')
                .doc()
                .set({
              'comment': value,
              'username': user!.username,
              'photoUrl': user.photoUrl,
              'publishedDate': DateTime.now(),
              'userId': user.uid,
              'postId': widget.post.postId,
              'commendId': commentId,
            });
            value = '';
            setState(() {});
          },
          style: const TextStyle(color: AppColors.whiteColor),
          decoration: const InputDecoration(
              hintText: 'Add comment',
              hintStyle: TextStyle(color: AppColors.lightText),
              border: InputBorder.none),
        ),
      ])
              .box
              .rounded
              .color(AppColors.lightWhite)
              .make()
              .pOnly(bottom: 10, left: 10, right: 10)
              .centered()),
    );
  }
}
