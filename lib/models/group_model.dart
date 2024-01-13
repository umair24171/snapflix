// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GroupModel {
  String name;
  String description;
  String image;
  String coverImage;
  String id;
  String adminId;
  List members;
  DateTime createdAt;
  bool sendMessageStatus;
  bool editGroupSettings;
  GroupModel(
      {required this.name,
      required this.description,
      required this.image,
      required this.coverImage,
      required this.id,
      required this.adminId,
      required this.members,
      required this.createdAt,
      required this.sendMessageStatus,
      required this.editGroupSettings});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'image': image,
      'coverImage': coverImage,
      'id': id,
      'adminId': adminId,
      'members': members,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'sendMessageStatus': sendMessageStatus,
      'editGroupSettings': editGroupSettings,
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      coverImage: map['coverImage'] as String,
      id: map['id'] as String,
      adminId: map['adminId'] as String,
      members: List.from((map['members'] as List)),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      sendMessageStatus: map['sendMessageStatus'] as bool,
      editGroupSettings: map['editGroupSettings'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupModel.fromJson(String source) =>
      GroupModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
