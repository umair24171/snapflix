// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snapflix/Utils/additional_methods.dart';
import 'package:snapflix/Utils/bottom_navigation.dart';
import 'package:snapflix/Utils/navigator.dart';
import 'package:snapflix/configs/zego_cloud.dart';
import 'package:snapflix/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> userSignUp(
      {required String email,
      required String password,
      required String username,
      required String photoUrl,
      required String confirmPassword,
      required BuildContext context}) async {
    bool isRegistered = false;
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel user = UserModel(
          uid: credential.user!.uid,
          username: username,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          photoUrl: photoUrl,
          following: [],
          followers: []);
      _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(user.toMap());
      if (credential.user != null) {
        isRegistered = true;
      }
    } catch (e) {
      showSnackBar(
        'An error accured',
        e.toString(),
      );
    }
    return isRegistered;
  }

  userLogin(
      {required BuildContext context,
      required String email,
      required String password,
      required bool isLoading}) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        showSnackBar('Congratulations', 'You are logged in');
        navReplace(context, BottomNavigationBarSet());

        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(credential.user!.uid)
                .get();

        ZegoUIKitPrebuiltCallInvitationService().init(
          appID: ZegoCLouds.appId /*input your AppID*/,
          appSign: ZegoCLouds.appSignIn /*input your AppSign*/,
          userID: credential.user!.uid,
          userName: snapshot.data()!['username'],
          plugins: [ZegoUIKitSignalingPlugin()],
        );
      }
    } catch (e) {
      isLoading = false;
      showSnackBar('An error accured', e.toString());
    }
  }

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credentials = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      final UserCredential userCredential =
          await _auth.signInWithCredential(credentials);
      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          UserModel user1 = UserModel(
              uid: user.uid,
              username: user.displayName!,
              email: user.email!,
              password: '',
              confirmPassword: '',
              photoUrl: user.photoURL!,
              following: [],
              followers: []);
          _firestore.collection('users').doc(user.uid).set(user1.toMap());
        }
        res = true;
      }
    } catch (e) {
      showSnackBar('Error Accured', e.toString());
      res = false;
    }
    return res;
  }
}
