import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapflix/Utils/additional_methods.dart';
import 'package:snapflix/models/call_model.dart';

class CallMethods {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  String callId = '';

  Future<void> addCall(
      String callId, String reciverUid, String senderUid) async {
    try {
      await firestore.collection('calls').doc(callId).set({
        'callId': callId,
        'receiverId': reciverUid,
        'senderId': senderUid,
      });
    } catch (e) {
      showSnackBar('error', e.toString());
    }
  }

  Future<void> checkCallId(String reciverUid, String senderUid) async {
    try {
      await firestore
          .collection('calls')
          .where('receiverId', isEqualTo: reciverUid)
          .get()
          .then((value) {
        for (var i in value.docs) {
          if (i['receiverId'] == reciverUid) {
            callId = i['callId'];
            // firestore.collection('calls').doc(i.id).delete();
          }
        }
      });
    } catch (e) {
      showSnackBar('error', e.toString());
    }
  }

  // Future<void> deleteCall(String callId) async {
  //   try {
  //     await firestore.collection('calls').doc(callId).delete();
  //   } catch (e) {
  //     showSnackBar('error', e.toString());
  //   }
  // }

  void makeCall({required Call call, required String receiverId}) async {
    try {
      await firestore
          .collection('calls')
          .doc(auth.currentUser!.uid)
          .set(call.toMap());
      firestore.collection('calls').doc(receiverId).set(call.toMap());
    } catch (e) {
      showSnackBar('error', e.toString());
    }
  }

  void endCall(String callerId, String receiverId) async {
    try {
      await firestore.collection('calls').doc(callerId).delete();
      await firestore.collection('calls').doc(receiverId).delete();
    } catch (e) {
      showSnackBar('error', e.toString());
    }
  }
}

class CallUtile extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  String _callId = '';
  String get callId => _callId;
  void setCallId(String callId) {
    _callId = callId;
    notifyListeners();
  }

  Future<void> addCall(
      String callId, String reciverUid, String senderUid) async {
    try {
      await firestore.collection('calls').doc(callId).set({
        'callId': callId,
        'receiverId': reciverUid,
        'senderId': senderUid,
      });
    } catch (e) {
      showSnackBar('error', e.toString());
    }
  }

  Future<void> checkCallId(String reciverUid, String senderUid) async {
    try {
      await firestore
          .collection('calls')
          .where('receiverId', isEqualTo: reciverUid)
          .where('senderId', isEqualTo: senderUid)
          .get()
          .then((value) {
        for (var i in value.docs) {
          if (i['receiverId'] == reciverUid) {
            debugPrint('callId: ${i['callId']}');
            setCallId(i['callId']);

            // firestore.collection('calls').doc(i.id).delete();
          }
        }
      });
    } catch (e) {
      showSnackBar('error', e.toString());
    }
  }

  Future<void> deleteCallId(String reciverUid, String senderUid) async {
    try {
      await firestore
          .collection('calls')
          .where('receiverId', isEqualTo: reciverUid)
          .where('senderId', isEqualTo: senderUid)
          .get()
          .then((value) {
        for (var i in value.docs) {
          if (i['receiverId'] == reciverUid) {
            firestore.collection('calls').doc(i.id).delete();
          }
        }
      });
    } catch (e) {
      showSnackBar('error', e.toString());
    }
  }
}
