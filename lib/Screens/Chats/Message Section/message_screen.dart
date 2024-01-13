import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Constants/app_images.dart';
// import 'package:snapflix/Screens/Chats/Call%20Section/call_back.dart';
import 'package:snapflix/Screens/Chats/Call%20Section/call_screen.dart';
import 'package:snapflix/Screens/Chats/groups/group_settings_screen.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/configs/zego_cloud.dart';
import 'package:snapflix/firebase_methods/call_methods.dart';
import 'package:snapflix/models/call_model.dart';
import 'package:snapflix/models/chat_model.dart';
import 'package:snapflix/models/group_model.dart';
import 'package:snapflix/models/user_model.dart';
import 'package:snapflix/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key, this.user, this.groupModel});

  getConversationId() =>
      FirebaseAuth.instance.currentUser!.uid.hashCode <= user!.uid.hashCode
          ? '${FirebaseAuth.instance.currentUser!.uid}_${user!.uid}'
          : '${user!.uid}_${FirebaseAuth.instance.currentUser!.uid}';

  final UserModel? user;
  final GroupModel? groupModel;
  Size get preferSize => const Size.fromHeight(70);

  final TextEditingController messageController = TextEditingController();
  bool isMe = false;
  @override
  Widget build(BuildContext context) {
    var callProvider = Provider.of<CallUtile>(context, listen: false);
    var currentUser = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              navPop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: AppColors.whiteColor,
            )),
        backgroundColor: AppColors.lightWhite,
        toolbarHeight: preferSize.height,
        title: HStack([
          CircleAvatar(
            backgroundImage: NetworkImage(user?.photoUrl ?? groupModel!.image),
          ),
          VStack([
            user != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: SizedBox(
                      width: 100,
                      child: Text(
                        user!.username,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 6, bottom: 5),
                    child: SizedBox(
                      width: 80,
                      child: Text(
                        groupModel!.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 15, color: AppColors.whiteColor),
                      ),
                    ),
                  ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Online',
                style: TextStyle(color: AppColors.onOffColor, fontSize: 14),
              ),
            )
          ]),
        ]),
        actions: [
          IconButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('calls')
                        .where('receiverId', isEqualTo: currentUser?.uid ?? '')
                        .where('senderId', isEqualTo: user?.uid ?? '')
                        .get()
                        .then((value) {
                      for (var i in value.docs) {
                        callProvider.setCallId(i['callId']);
                      }
                      navPush(
                          context,
                          ZegoCloudVideoCallScreen(
                            callId: callProvider.callId,
                            user: user!,
                          ));
                    });
                    if (callProvider.callId.isEmpty) {
                      var callId = const Uuid().v4();
                      callProvider
                          .addCall(
                              callId, user?.uid ?? '', currentUser?.uid ?? '')
                          .then((value) {
                        navPush(
                            context,
                            ZegoCloudVideoCallScreen(
                              callId: callId,
                              user: user!,
                            ));
                      });
                    }
                    ZegoSendCallInvitationButton(
                      callID: callProvider.callId,
                      isVideoCall: true,
                      resourceID:
                          "zego_videocall", //You need to use the resourceID that you created in the subsequent steps. Please continue reading this document.
                      invitees: [
                        ZegoUIKitUser(
                          id: user!.uid,
                          name: user!.username,
                        ),
                      ],
                    );
                    // Call call = Call(
                    //     callerId: FirebaseAuth.instance.currentUser!.uid,
                    //     callerName: currentUser!.username,
                    //     callerPic: currentUser.photoUrl,
                    //     receiverId: user!.uid,
                    //     receiverName: user!.username,
                    //     receiverPic: user!.photoUrl,
                    //     callId: callId,
                    //     hasDialled: false);

                    // CallMethods().makeCall(call: call, receiverId: user!.uid);

                    // ZegoSendCallInvitationButton(
                    //   isVideoCall: true,
                    //   resourceID:
                    //       "resource-id", //You need to use the resourceID that you created in the subsequent steps. Please continue reading this document.
                    //   invitees: [
                    //     ZegoUIKitUser(
                    //       id: user!.uid,
                    //       name: user!.username,
                    //     ),
                    //   ],
                    // );
                    // navPush(
                    //   context,
                    //   ZegoCloudVideoCallScreen(
                    //     call: call,
                    //     user: user!,
                    //   ));
                    // ZegoSendCallInvitationButton(
                    //   callID: '123456',
                    //   isVideoCall: true,
                    //   resourceID:
                    //       "video_calling", //You need to use the resourceID that you created in the subsequent steps. Please continue reading this document.
                    //   invitees: [
                    //     ZegoUIKitUser(
                    //       id: user!.uid,
                    //       name: user!.username,
                    //     ),
                    //   ],
                    // );
                  },
                  icon: SvgPicture.asset(AppImages.vedioCallIcon))
              .box
              .color(AppColors.lightWhite)
              .roundedFull
              .make(),
          IconButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('calls')
                        .where('receiverId', isEqualTo: currentUser?.uid ?? '')
                        .where('senderId', isEqualTo: user?.uid ?? '')
                        .get()
                        .then((value) {
                      for (var i in value.docs) {
                        callProvider.setCallId(i['callId']);
                      }
                      ZegoSendCallInvitationButton(
                        callID: callProvider.callId,
                        isVideoCall: false,
                        resourceID:
                            "zego_videocall", //You need to use the resourceID that you created in the subsequent steps. Please continue reading this document.
                        invitees: [
                          ZegoUIKitUser(
                            id: user?.uid ?? '',
                            name: user?.username ?? '',
                          ),
                        ],
                      );
                      navPush(
                          context,
                          ZegoCloudVideoCallScreen(
                            callId: callProvider.callId,
                            user: user!,
                          ));
                    });
                    if (callProvider.callId.isEmpty) {
                      var callId = const Uuid().v4();
                      callProvider
                          .addCall(
                              callId, user?.uid ?? '', currentUser?.uid ?? '')
                          .then((value) {
                        ZegoSendCallInvitationButton(
                          callID: callId,
                          isVideoCall: false,
                          resourceID:
                              "zego_videocall", //You need to use the resourceID that you created in the subsequent steps. Please continue reading this document.
                          invitees: [
                            ZegoUIKitUser(
                              id: user!.uid,
                              name: user!.username,
                            ),
                          ],
                        );
                        navPush(
                            context,
                            ZegoCloudVideoCallScreen(
                              callId: callId,
                              user: user!,
                            ));
                      });
                    }
                  },
                  icon: const Icon(Icons.call))
              .box
              .color(AppColors.lightWhite)
              .roundedFull
              .make(),
          if (user == null)
            PopupMenuButton(
                onSelected: (value) {
                  if (value == 'Group Info') {
                    navPush(
                        context, GroupSettingsScreen(groupModel: groupModel!));
                  }
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 30,
                ),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: 'Group Info',
                      child: Text('Group Info'),
                    )
                  ];
                })
        ],
      ),
      body: StreamBuilder(
          stream: user != null
              ? FirebaseFirestore.instance
                  .collection('chats')
                  .doc(getConversationId())
                  .collection('messages')
                  .orderBy('time', descending: true)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('chats')
                  .doc(groupModel!.id)
                  .collection('messages')
                  .orderBy('time', descending: true)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No messages yet"),
                );
              }

              return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    ChatModel chatModel =
                        ChatModel.fromMap(snapshot.data!.docs[index].data());
                    isMe = chatModel.senderId ==
                            FirebaseAuth.instance.currentUser!.uid
                        ? true
                        : false;
                    return MessageBubble(
                      sender: chatModel.name,
                      text: chatModel.message,
                      isMe: isMe,
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      bottomNavigationBar: user == null &&
              groupModel!.sendMessageStatus == true &&
              groupModel!.adminId != FirebaseAuth.instance.currentUser!.uid
          ? Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: AppColors.lightWhite),
              child: const Text(
                'Only admins can send the messages',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.whiteColor),
              ),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: AppColors.lightWhite),
              child: HStack(
                [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.lightWhite,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        onSubmitted: (value) {
                          // FirebaseFirestore.instance.collection('chats').doc()
                        },
                        controller: messageController,
                        cursorColor: AppColors.lightText,
                        decoration: const InputDecoration(
                          hintText: "Type a message...",
                          hintStyle: TextStyle(color: AppColors.lightText),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (user != null) {
                        String randomId = const Uuid().v4();
                        ChatModel chatModel = ChatModel(
                            id: randomId,
                            name: Provider.of<UserProvider>(context,
                                    listen: false)
                                .user!
                                .username,
                            message: messageController.text,
                            time: DateTime.now(),
                            avatarUrl: user!.photoUrl,
                            senderId: FirebaseAuth.instance.currentUser!.uid,
                            receiverId: user!.uid);
                        FirebaseFirestore.instance
                            .collection('chats')
                            .doc(getConversationId())
                            .collection('messages')
                            .doc(randomId)
                            .set(chatModel.toMap());
                        messageController.clear();
                      } else {
                        String randomId = const Uuid().v4();
                        ChatModel chatModel = ChatModel(
                            id: randomId,
                            name: Provider.of<UserProvider>(context,
                                    listen: false)
                                .user!
                                .username,
                            message: messageController.text,
                            time: DateTime.now(),
                            avatarUrl: groupModel!.image,
                            senderId: FirebaseAuth.instance.currentUser!.uid,
                            receiverId: groupModel!.id);
                        FirebaseFirestore.instance
                            .collection('chats')
                            .doc(groupModel!.id)
                            .collection('messages')
                            .doc(randomId)
                            .set(chatModel.toMap());
                        messageController.clear();
                      }
                    },
                  ),
                ],
              ).pOnly(),
            ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;

  const MessageBubble(
      {super.key,
      required this.sender,
      required this.text,
      required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: VStack(
        [
          Text(sender).text.gray500.make(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: isMe ? AppColors.pinkColor : AppColors.lightWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              text,
              style: TextStyle(
                  color: isMe ? AppColors.whiteColor : AppColors.whiteColor),
            ).text.make(),
          ),
        ],
        crossAlignment: CrossAxisAlignment.start,
        alignment: MainAxisAlignment.start,
      ).pOnly(bottom: 8),
    );
  }
}

class ZegoCloudVideoCallScreen extends StatelessWidget {
  const ZegoCloudVideoCallScreen(
      {super.key, required this.callId, required this.user});
  final String callId;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<UserProvider>(context, listen: false).user;
    var provider = Provider.of<CallUtile>(context, listen: false);
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
          appID: ZegoCLouds.appId,
          appSign: ZegoCLouds.appSignIn,
          callID: callId,
          userID: FirebaseAuth.instance.currentUser!.uid,
          userName:
              Provider.of<UserProvider>(context, listen: false).user!.username,
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
          events: ZegoUIKitPrebuiltCallEvents(
            onCallEnd: (event, defaultAction) {
              provider.setCallId('');
              provider.deleteCallId(currentUser?.uid ?? '', user.uid);
              navPop(context);
            },
          )),
    );
  }
}
