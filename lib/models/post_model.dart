// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String username;
  final String caption;
  PostType postType;
  final String imageUrl;
  final String photoUrl;
  final String uid;
  final String postId;
  final DateTime publishedDate;
  final List likes;
  final List comments;
  final String thumbnailUrl;
  final String category;

  PostModel(
      {required this.username,
      required this.caption,
      required this.imageUrl,
      required this.photoUrl,
      required this.uid,
      required this.postId,
      required this.publishedDate,
      required this.likes,
      required this.comments,
      required this.postType,
      required this.thumbnailUrl,
      required this.category});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'postType': postType.toString().split('.').last,
      'caption': caption,
      'imageUrl': imageUrl,
      'photoUrl': photoUrl,
      'thumbnailUrl': thumbnailUrl,
      'category': category,
      'uid': uid,
      'postId': postId,
      'publishedDate': publishedDate,
      'likes': likes,
      'comments': comments,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
        username: map['username'] as String,
        postType: _getPostTypeFromString(map['postType'] as String),
        caption: map['caption'] as String,
        imageUrl: map['imageUrl'] as String,
        category: map['category'] as String,
        photoUrl: map['photoUrl'] as String,
        thumbnailUrl: map['thumbnailUrl'] as String,
        uid: map['uid'] as String,
        postId: map['postId'] as String,
        publishedDate: (map['publishedDate'] as Timestamp).toDate(),
        likes: List.from((map['likes'] as List)),
        comments: List.from((map['comments'] as List)));
  }
  static PostType _getPostTypeFromString(String value) {
    switch (value) {
      case 'text':
        return PostType.text;
      case 'image':
        return PostType.image;
      case 'video':
        return PostType.video;
      default:
        return PostType.text;
    }
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum PostType { text, image, video }
