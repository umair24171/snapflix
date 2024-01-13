// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final String photoUrl;
  final List following;
  final List followers;

  UserModel(
      {required this.uid,
      required this.username,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.photoUrl,
      required this.following,
      required this.followers});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'photoUrl': photoUrl,
      'following': following,
      'followers': followers,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'] as String,
        username: map['username'] as String,
        email: map['email'] as String,
        password: map['password'] as String,
        confirmPassword: map['confirmPassword'] as String,
        photoUrl: map['photoUrl'] as String,
        following: List.from((map['following'] as List)),
        followers: List.from(
          (map['followers'] as List),
        ));
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
