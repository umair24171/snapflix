import 'package:snapflix/firebase_methods/group_methods.dart';
import 'package:snapflix/models/group_model.dart';
import 'package:flutter/material.dart';

class GroupProvider with ChangeNotifier {
  bool initialStatus = false;

  updateGroupSendMessageStatus(GroupModel group, bool value) async {
    initialStatus = value;
    GroupMethods().sendMessages(group, initialStatus);
    notifyListeners();
    // return initialStatus;
  }
}
