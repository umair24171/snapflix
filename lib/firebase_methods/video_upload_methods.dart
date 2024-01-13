import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:snapflix/models/post_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'package:video_compress/video_compress.dart';

class VideoUpload {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // upload video
  uploadVideo(String caption, String videoPath) async {
    try {
      String uuid = const Uuid().v4();
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      // get id
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl =
          await _uploadVideoToStorage(const Uuid().v4(), videoPath);
      String thumbnail =
          await _uploadImageToStorage(const Uuid().v4(), videoPath);

      PostModel video = PostModel(
        username: userDoc['username'],
        caption: caption,
        imageUrl: videoUrl,
        photoUrl: userDoc['photoUrl'],
        uid: uid,
        postId: uuid,
        publishedDate: DateTime.now(),
        likes: [],
        comments: [],
        category: '',
        postType: PostType.video,
        thumbnailUrl: thumbnail,
      );

      await firestore.collection('posts').doc(uuid).set(
            video.toMap(),
          );
    } catch (e) {
      Get.snackbar(
        'Error Uploading Video',
        e.toString(),
      );
    }
  }
}
