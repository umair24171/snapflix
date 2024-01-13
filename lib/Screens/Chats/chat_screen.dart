import 'package:snapflix/Screens/Chats/groups/add_participants_screen.dart';
import 'package:snapflix/Screens/Chats/groups/all_groups_screen.dart';
import 'package:snapflix/Screens/Chats/groups/group_settings_screen.dart';
import 'package:snapflix/Screens/Chats/widgets/recent_chats_list.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Screens/Chats/widgets/stories_list_view.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.message_outlined,
            color: AppColors.whiteColor,
          ),
        ),
        body: VStack([
          HStack(alignment: MainAxisAlignment.spaceBetween, [
            "Private Chats"
                .text
                .maxFontSize(20)
                .minFontSize(18)
                .bold
                .color(AppColors.whiteColor)
                .make()
                .pOnly(top: size.height * 0.05),
            PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: AppColors.whiteColor,
                  size: 27,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: TextButton(
                        onPressed: () {
                          navPush(context, AddGroupParticipants());
                        },
                        child: const Text(
                          "Create Group",
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: TextButton(
                        onPressed: () {
                          navPush(context, AllGroupsScreen());
                        },
                        child: const Text(
                          "Yours Groups",
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ];
                }).pOnly(top: 40, left: 140)
          ]),
          "Recent Chats"
              .text
              .color(AppColors.lightText)
              .maxFontSize(15)
              .minFontSize(15)
              .make()
              .pOnly(top: 20),
          //stories
          const MyStoriesList().pOnly(
            top: size.height * 0.03,
          ),
          //Recent chats
          HStack(
            [
              "All conversations (19)"
                  .text
                  .color(AppColors.whiteColor)
                  .maxFontSize(14)
                  .minFontSize(12)
                  .make()
                  .pOnly(top: 20),
              "Message Requests (29)"
                  .text
                  .color(AppColors.lightText)
                  .maxFontSize(14)
                  .minFontSize(12)
                  .make()
                  .pOnly(top: 20, left: 10),
            ],
          ),
          const RecentChatList().pOnly(top: size.height * 0.05),
        ]).scrollVertical().pOnly(left: 10),
      ),
    );
  }
}
