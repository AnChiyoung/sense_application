import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/feed/feed_model.dart';

class FeedProvider with ChangeNotifier {
  List<FeedTagModel> _feedTags = [];
  List<FeedTagModel> get feedTags => _feedTags;

  int _selectedTagId = 0;
  int get selectedTagId => _selectedTagId;

  List<FeedPostModel> _feedPosts = [];
  List<FeedPostModel> get feedPosts => _feedPosts;

  Future<void> initializeFeed() async {
    _feedTags = await ApiService.getRecommendTags();
    changeTagId(_feedTags[0].id);
  }

  void changeTagId(int tagId) {
    _selectedTagId = tagId;
    getFeedPosts();
  }

  Future<void> getFeedPosts() async {
    if (_selectedTagId == 0) return;
    _feedPosts = await ApiService.getRecommendPostsByTagId(_selectedTagId);
    notifyListeners();
  }

  void searchFeed(String searchTerm) {}
}
