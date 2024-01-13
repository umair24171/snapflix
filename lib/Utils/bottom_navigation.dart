import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Screens/Chats/chat_screen.dart';
import 'package:snapflix/Screens/Discover%20New/discover_new_screen.dart';
import 'package:snapflix/Screens/Home/home_screen.dart';
import 'package:snapflix/Screens/Profile/profile.dart';
import 'package:snapflix/Screens/Reels/video_screen.dart';
import 'package:snapflix/providers/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:velocity_x/velocity_x.dart';

class BottomNavigationBarSet extends StatelessWidget {
  BottomNavigationBarSet({Key? key}) : super(key: key);

  final GlobalKey<CurvedNavigationBarState> navigationKey =
      GlobalKey<CurvedNavigationBarState>();

  // int currentIndex = 2;
  List<Widget> bottomList = [
    const DiscoverNew(),
    const ChatScreen(),
    const HomeScreen(),
    VideoScreen(),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    var bottomProvider = context.watch<BottomNavigationProvider>();
    return Scaffold(
      backgroundColor: Colors.white24,
      bottomNavigationBar: CurvedNavigationBar(
        key: navigationKey,
        backgroundColor: AppColors.transparentColor,
        color: Colors.black,
        buttonBackgroundColor: AppColors.blackColor,
        height: 50,
        items: [
          VStack([
            const Icon(Icons.new_releases, color: AppColors.pinkColor)
                .centered(),
            "Discover"
                .text
                .minFontSize(9)
                .maxFontSize(9)
                .color(AppColors.pinkColor)
                .make()
                .centered()
          ]).centered(),
          VStack([
            const Icon(Icons.message, color: AppColors.pinkColor).centered(),
            "Chats"
                .text
                .minFontSize(10)
                .maxFontSize(12)
                .color(AppColors.pinkColor)
                .make()
                .centered()
          ]).centered(),
          VStack([
            const Icon(Icons.home, color: AppColors.pinkColor).centered(),
            "Home"
                .text
                .minFontSize(10)
                .maxFontSize(12)
                .color(AppColors.pinkColor)
                .make()
                .centered()
          ]).centered(),
          VStack([
            const Icon(Icons.play_arrow, color: AppColors.pinkColor).centered(),
            "Reels"
                .text
                .minFontSize(10)
                .maxFontSize(12)
                .color(AppColors.pinkColor)
                .make()
                .centered()
          ]).centered(),
          VStack([
            const Icon(Icons.person, color: AppColors.pinkColor).centered(),
            "Profile"
                .text
                .minFontSize(10)
                .maxFontSize(12)
                .color(AppColors.pinkColor)
                .make()
                .centered()
          ]).centered(),
        ],
        index: 2,
        onTap: (index) {
          bottomProvider.setcurrentIndex = index;
        },
        animationDuration: const Duration(milliseconds: 600),
        animationCurve: Curves.decelerate,
      ),
      body: bottomList[bottomProvider.currentIndex],
    );
  }
}
