import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:snapflix/Utils/additional_methods.dart';
import 'package:snapflix/models/group_model.dart';

class GroupMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  createGroup(GroupModel groupModel, String groupId) async {
    try {
      await _firestore
          .collection('groups')
          .doc(groupId)
          .set(groupModel.toMap());
    } catch (e) {
      showSnackBar('Error', e.toString());
    }
  }

  muteNotifications(GroupModel group, bool value) async {
    try {
      await _firestore
          .collection('groups')
          .doc(group.id)
          .update({'mute': value});
    } catch (e) {
      showSnackBar('Error', e.toString());
    }
  }

  sendMessages(
    GroupModel group,
    bool value,
  ) async {
    try {
      await _firestore
          .collection('groups')
          .doc(group.id)
          .update({'sendMessageStatus': value});
    } catch (e) {
      showSnackBar('Error', e.toString());
    }
  }
}
