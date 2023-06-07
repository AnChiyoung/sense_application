import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/feed/comment_model.dart';
import 'package:sense_flutter_application/models/feed/feed_model.dart';

class FeedProvider with ChangeNotifier {
  List<FeedTagModel> _feedTags = [];
  List<FeedTagModel> get feedTags => _feedTags;

  int _selectedTagId = 0;
  int get selectedTagId => _selectedTagId;

  // List<FeedPostModel> _feedPosts = [];
  // List<FeedPostModel> get feedPosts => _feedPosts;
  List<FeedPreviewModel> _feedPosts = [];
  List<FeedPreviewModel> get feedPosts => _feedPosts;

  // Future<void> initializeFeed() async {
  //   _feedTags = await ApiService.getRecommendTags();
  //   changeTagId(_feedTags[0].id);
  // }
  //
  // void changeTagId(int tagId) {
  //   _selectedTagId = tagId;
  //   getFeedPosts();
  // }
  //
  // Future<void> getFeedPosts() async {
  //   if (_selectedTagId == 0) return;
  //   _feedPosts = await ApiService.getRecommendPostsByTagId(_selectedTagId);
  //   notifyListeners();
  // }

  void searchFeed(String searchTerm) {}


  /// 2023.05.08.
  List<bool> _sortState = [false, true];
  List<bool> get sortState => _sortState;

  void sortStateChange(List<bool> state) {
    _sortState = state;
    notifyListeners();
  }

  bool _commentState = false;
  bool get commentState => _commentState;

  void commentStateChange(bool state) {
    _commentState = state;
    notifyListeners();
  }

  // bool _commentFieldUpdate = false;
  // bool get commentFieldUpdate => _commentFieldUpdate;
  // int _commentCount = CommentModel.description.length;
  // int get commentCount => _commentCount;
  //
  // void commentFieldUpdateChange(bool state) {
  //   _commentFieldUpdate = state;
  //   _commentCount = CommentModel.description.length;
  //   notifyListeners();
  // }

  List<bool> _reportReason = [false, false, false, false, false];
  List<bool> get reportReason => _reportReason;

  void reportReasonStateChange(List<bool> state) {
    _reportReason = state;
    notifyListeners();
  }

  bool _likeFieldUpdate = false;
  bool get likeFieldUpdate => _likeFieldUpdate;

  void likeFieldUpdateState(bool state) {
    _likeFieldUpdate = state;
    notifyListeners();
  }

  /// select tag number provider
  int _selectTagNumber = 0;
  int get selectTagNumber => _selectTagNumber;

  void selectTagNumberChange(int number) {
    _selectTagNumber = number;
    notifyListeners();
  }
}
