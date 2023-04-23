import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/feed/feed_model.dart';

class FeedSearchProvider with ChangeNotifier {
  String _searchTerm = '';
  String get searchTerm => _searchTerm;

  List<FeedPostDetailModel> _feedPosts = [];
  List<FeedPostDetailModel> get feedPosts => _feedPosts;

  final List<FeedProductModel> _feedProducts = [];
  List<FeedProductModel> get feedProducts => _feedProducts;

  void initialize(String searchTerm) {
    _searchTerm = searchTerm;
    notifyListeners();
  }

  void changeSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    searchPost();
  }

  Future<void> searchPost() async {
    debugPrint('searchPost()');
    _feedPosts = await ApiService.getPosts(searchTerm: _searchTerm);
    notifyListeners();
  }
}
