import 'package:snapflix/models/post_model.dart';
import 'package:snapflix/models/user_model.dart';
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  bool isSearching = false;
  bool selectedCategory = false;
  String searchValue = '';
  List<PostModel> posts = [];
  List<PostModel> searchedPosts = [];
  String searchedCategory = '';

  void changeSearchStatus() {
    isSearching = !isSearching;
    notifyListeners();
  }

  void searchUser(String value) {
    searchValue = value;
    notifyListeners();
  }

  postsList(PostModel post) {
    posts.add(post);
    notifyListeners();
  }

  isSearchingOnCategory(bool value) {
    selectedCategory = value;
    notifyListeners();
  }

  // saerching the users
  bool _isSearchingUser = false;
  bool get isSearhingUser => _isSearchingUser;
  void setSeachingUser(bool value) {
    _isSearchingUser = value;
    notifyListeners();
  }

  List<UserModel> users = [];
  List<UserModel> searchedUsers = [];
}
