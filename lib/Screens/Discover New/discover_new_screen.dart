import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Screens/Reels/add_post_screen.dart';
import 'package:snapflix/Screens/Reels/widgets/post_list.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/models/post_model.dart';
import 'package:snapflix/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

class DiscoverNew extends StatelessWidget {
  const DiscoverNew({super.key});

  Size get preferredSize => const Size.fromHeight(100);
  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'All',
      'Politics',
      'Sports',
      'Education',
      'Entertainment',
      'Gangster',
      'Politics'
    ];
    var provider = Provider.of<SearchProvider>(context);
    // var getWidth = MediaQuery.of(context).size.width;
    // var getHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: AppColors.blackColor,
        appBar: AppBar(
          toolbarHeight: preferredSize.height,
          backgroundColor: AppColors.lightWhite,
          automaticallyImplyLeading: false,
          title: Column(children: [
            const Text("Discover New",
                style: TextStyle(color: AppColors.whiteColor)),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: customSearchBar(() {}, (value) {}),
            // ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                    // color: AppColors.pinkColor,
                    border: Border.all(color: AppColors.whiteColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.add,
                  color: AppColors.whiteColor,
                  size: 30,
                ).onTap(() => navPush(context, AddPostScreen())),
              ),
            )
          ]),
        ),
        body: SingleChildScrollView(
          primary: true,
          child: Column(children: [
            //Row Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {
                          if (categories[index] == 'All') {
                            provider.searchedPosts.clear();
                            provider.isSearchingOnCategory(false);
                          } else {
                            provider.isSearchingOnCategory(true);
                            provider.searchedCategory = categories[index];
                            debugPrint(
                                'selected category ${provider.searchedCategory}');
                            provider.searchedPosts.clear();
                            for (var category in categories) {
                              if (category.toLowerCase().contains(
                                  provider.searchedCategory.toLowerCase())) {
                                provider.isSearchingOnCategory(true);
                                provider.searchedCategory = categories[index];
                                debugPrint(
                                    'selected category ${provider.searchedCategory}');
                                provider.searchedPosts.clear();
                                for (var post in provider.posts) {
                                  if (post.category.toLowerCase().contains(
                                      provider.searchedCategory
                                          .toLowerCase())) {
                                    provider.searchedPosts.add(post);
                                  }
                                }
                              }
                            }
                          }

                          // if (categories[index] == 'Politics') {
                          //   provider.isSearchingOnCategory(true);
                          //   provider.searchedCategory = categories[index];
                          //   debugPrint(
                          //       'selected category ${provider.searchedCategory}');
                          //   provider.searchedPosts.clear();
                          //   for (var i in provider.posts) {
                          //     if (i.category.toLowerCase().contains(
                          //         provider.searchedCategory.toLowerCase())) {
                          //       provider.searchedPosts.add(i);
                          //     }
                          //   }
                          // } else {
                          //   provider.isSearchingOnCategory(false);
                          //   provider.searchedPosts.clear();
                          // }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            width: 100,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: AppColors.lightWhite,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: AppColors.greColor, width: 1)),
                            child: Text(
                              categories[index],
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                      );
                    })),
              ),
            ),

            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .where('postType', isEqualTo: 'image')
                    .orderBy('publishedDate', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("No posts yet"),
                      );
                    }
                    var data = snapshot.data?.docs;
                    provider.posts = data
                            ?.map((e) => PostModel.fromMap(e.data()))
                            .toList() ??
                        [];
                    // PostModel post =
                    //     PostModel.fromMap(snapshot.data!.docs[index].data());
                    // provider.postsList(post);
                    return ListView.builder(
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.selectedCategory
                            ? provider.searchedPosts.length
                            : provider.posts.length,
                        itemBuilder: (context, index) {
                          List likes =
                              snapshot.data!.docs[index].data()['likes'];
                          return PostList(
                              post: provider.selectedCategory
                                  ? provider.searchedPosts[index]
                                  : provider.posts[index],
                              likes: likes);
                        });
                  } else {
                    return ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ).pOnly(left: 10, right: 10, top: 10),
                        );
                      },
                    );
                  }
                })
          ]),
        ));
  }
}
