import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:snapflix/Utils/additional_methods.dart';
import 'package:snapflix/models/post_model.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class FirestoreHelper {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<File> pickImage() async {
    final picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    // if (file == null) {}
    return File(file!.path);
  }

  Future<String> uploadFile(
      String childName,
      // String name,
      File file,
      BuildContext context) async {
    String randomId = const Uuid().v4();
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = _storage.ref().child(
        '$childName/${randomId}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    var imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }

  addPost(PostModel post) async {
    try {
      await _firestore.collection('posts').doc(post.postId).set(post.toMap());
    } catch (e) {}
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> currentUser =
          await _firestore.collection('users').doc(uid).get();
      DocumentSnapshot<Map<String, dynamic>> followUser =
          await _firestore.collection('users').doc(followId).get();
      if (uid == followId) {
        showSnackBar('Error', 'You can not follow yourself');
        return;
      }
      if (!currentUser.data()!['following'].contains(followId)) {
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      } else {
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      }
      if (followUser.data()!['followers'].contains(uid) == false) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });
      }
    } catch (e) {
      showSnackBar('Error', e.toString());
    }
  }
}
