import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/feed/comment_model.dart';
import 'package:sense_flutter_application/models/feed/feed_detail_model.dart';
import 'package:sense_flutter_application/models/feed/feed_model.dart';

class FeedProvider with ChangeNotifier {

  int _currentCommentListIndex = 0;
  int get currentCommentListIndex => _currentCommentListIndex;

  bool _isRecommentOption = false;
  bool get isRecommentOption => _isRecommentOption;

  ChildComment _childModel = ChildComment();
  ChildComment get childModel => _childModel;

  /// last input mode view
  Widget _lastHeader = Container();
  Widget get lastHeader => _lastHeader;
  Widget _lastCommentField = Container();
  Widget get lastCommentField => _lastCommentField;

  /// text editing contorller
  TextEditingController _inputController = TextEditingController();
  TextEditingController get inputController => _inputController;

  /// feed bottom field change
  bool _commentVisibility = false;
  bool get commentVisibility => _commentVisibility;

  void commentVisibilityChange(bool state) {
    _commentVisibility = state;
    notifyListeners();
  }

  /// feed bottom field initialize
  void feedBottomFieldInitialize() {
    _commentVisibility = false;
    _commentCount = -1;
    notifyListeners();
  }

  /// comment model request( + post id + sort state)
  /// list [0] = comment models
  /// list [1] = comment count
  List<CommentResponseModel> _commentModels = [];
  List<CommentResponseModel> get commentModels => _commentModels;

  void commentModelRequest(int postId, [String? sort]) async {
    _commentModels.clear();
    _commentModels = await CommentRequest().commentRequest(postId, sort!);
    sort == null ? {} : _sortState = sort;
    notifyListeners();
  }

  void updateSuccess(int postId, String sort) async {
    _updateMode = false;
    _commentModels = await CommentRequest().commentRequest(postId, sort);
    notifyListeners();
  }

  /// feed back button click! => info & data init
  void feedInfoInit() {
    _commentModels = [];
    _sortState = '-created';
    _commentCount = -1;
    _commentVisibility = false;

    notifyListeners();
  }

  // FeedDetailModel _feedDetailModel = FeedDetailModel();
  // FeedDetailModel get getFeedDetailModel => _feedDetailModel;
  /// 피드 상세 하단 댓글 및 좋아요 영역 업데이트 관련 추가 로직
  bool? _isCommented;
  bool get isCommented => _isCommented!;
  int _commentCount = -1;
  int get commentCount => _commentCount;
  bool? _isLiked;
  bool get isLiked => _isLiked!;
  int _likeCount = -1;
  int get likeCount => _likeCount;

  void feedDetailModelInitialize(bool? isCommented, int? commentCount, bool? isLiked, int? likeCount) {
    // print('notify!!');
    // model == null ? {} : _feedDetailModel = model;
    // model == null
    //     ? {_isCommented = isCommented!, _commentCount = commentCount!, _isLiked = isLiked!, _likeCount = likeCount!}
    //     : {_isCommented = _feedDetailModel.myComment!, _commentCount = _feedDetailModel.commentCount!, _isLiked = _feedDetailModel.isLiked!, _likeCount = _feedDetailModel.likeCount!};
    _isCommented = isCommented!; _commentCount = commentCount!; _isLiked = isLiked!; _likeCount = likeCount!;
    notifyListeners();
  }

  /// 답글로 변형
  bool _recommentMode = false;
  bool get recommentMode => _recommentMode;
  bool _updateMode = false;
  bool get updateMode => _updateMode;
  CommentResponseModel _selectCommentModel = CommentResponseModel();
  CommentResponseModel get selectCommentModel => _selectCommentModel;

  void selectCommentModelChange(CommentResponseModel commentResponseModel) {
    _selectCommentModel = commentResponseModel;
    notifyListeners();
  }

  void recommentModeChange(bool state, int index, [CommentResponseModel? commentModel]) {
    _currentCommentListIndex = index;
    _recommentMode = state;
    _inputController.clear();
    commentModel == CommentResponseModel() ? {} : _selectCommentModel = commentModel!;
    notifyListeners();
  }

  void recommentModeToCommentMode(int postId, String sort) async {
    _recommentMode = false;
    _commentModels = await CommentRequest().commentRequest(postId, sort!);
    _sortState = sort;
    _inputController.clear();
    notifyListeners();
  }

  void commentUpdateMode(CommentResponseModel model) {
    _selectCommentModel = model;
    _updateMode = true;
    notifyListeners();
  }

  void recommentUpdateMode(ChildComment childModel) {
    _childModel = childModel;
    _updateMode = true;
    _isRecommentOption = true;
    notifyListeners();
  }

  void isRecommentOptionInit() {
    _isRecommentOption = false;
    notifyListeners();
  }

  void lastHeaderWidgetSet(Widget headerType) {
    _lastHeader = headerType;
    notifyListeners();
  }

  void lastCommentWidgetSet(Widget commentType) {
    _lastCommentField = commentType;
    notifyListeners();
  }

  void commentInputResult(int postId, String sort, bool isCommented, int commentCount, bool isLiked, int likeCount) async {
    _inputButton = false;
    _isCommented = isCommented;
    _commentCount = commentCount;
    _isLiked = isLiked;
    _likeCount = likeCount;
    _commentModels = await CommentRequest().commentRequest(postId, sort);
    notifyListeners();
  }

  void commentDeleteResult(int postId, String sort, bool isCommented, int commentCount, bool isLiked, int likeCount) async {
    _inputButton = false;
    _isCommented = isCommented;
    _commentCount = commentCount;
    _isLiked = isLiked;
    _likeCount = likeCount;
    _commentModels = await CommentRequest().commentRequest(postId, sort);
    notifyListeners();
  }

  void commentUpdateResult(int postId, String sort) async {
    _commentModels = await CommentRequest().commentRequest(postId, sort);
    notifyListeners();
  }











  void feedCommentCountUpdate(int? commentCount) {
    _commentCount = commentCount!;
    notifyListeners();
  }


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
  String _sortState = '-created';
  String get sortState => _sortState;

  void sortStateChange(String state) {
    _sortState = state;
    notifyListeners();
  }

  bool _commentState = false;
  bool get commentState => _commentState;

  void commentStateChange(bool state) {
    _commentState = state;
    notifyListeners();
  }

  bool _commentFieldUpdate = false;
  bool get commentFieldUpdate => _commentFieldUpdate;
  // int _commentCount = CommentModel.description.length;
  // int get commentCount => _commentCount;
  //
  void commentFieldUpdateChange(bool state) {
    _commentFieldUpdate = state;
    // _commentCount = CommentModel.description.length;
    notifyListeners();
  }

  bool _recommentFieldUpdate = false;
  bool get recommentFieldUpdate => _recommentFieldUpdate;
  // int _commentCount = CommentModel.description.length;
  // int get commentCount => _commentCount;
  //
  void recommentFieldUpdateChange(bool state) {
    _recommentFieldUpdate = state;
    // _commentCount = CommentModel.description.length;
    notifyListeners();
  }

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

  int _selectTagIndex = 0;
  int get selectTagIndex => _selectTagIndex;

  void selectTagNumberChange(int selectTagId, int selectTagIndex) {
    _selectTagNumber = selectTagId;
    _selectTagIndex = selectTagIndex;
    notifyListeners();
  }

  // int _commentCount = -1;
  // int get commentCount => _commentCount;

  void commentCountUpdate(int state) {
    _commentCount = state;
    notifyListeners();
  }


  /// inputMode change => 0: comment, 1: recomment, 2: comment update
  // int _inputMode = 0;
  // int get inputMode => _inputMode;
  // // int _selectCommentId = 0;
  // // int get selectCommentId => _selectCommentId;
  // CommentResponseModel? _selectComment = CommentResponseModel();
  // CommentResponseModel? get selectComment => _selectComment;
  //
  // void inputModeChange(int state, [int? selectCommentId]) {
  //   _inputMode = state;
  //   if(state == 2) {
  //     // _selectCommentId = selectCommentId!;
  //   }
  //   notifyListeners();
  // }

  bool _inputButton = false;
  bool get inputButton => _inputButton;

  void inputButtonStateChange(bool state) {
    _inputButton = state;
    notifyListeners();
  }
}
