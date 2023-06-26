import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/feed/comment_model.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';
import 'package:sense_flutter_application/views/feed/feed_recomment_view.dart';
import 'package:sense_flutter_application/views/feed_improve/feed_bottom_field.dart';
import 'package:sense_flutter_application/views/feed_improve/feed_comment_header.dart';
import 'package:sense_flutter_application/views/feed_improve/feed_comment_row.dart';
import 'package:sense_flutter_application/views/feed_improve/feed_recomment_field.dart';
import 'package:sense_flutter_application/views/feed_improve/feed_recomment_header.dart';

class CommentView extends StatefulWidget {
  int? postId;
  double? bottomPadding;
  CommentView({Key? key, this.postId, this.bottomPadding}) : super(key: key);

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {

  @override
  Widget build(BuildContext context) {

    // List<CommentResponseModel> commentModelList = context.watch<FeedProvider>().commentModels;
    // int commentCount = commentModelList.length;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          bottom: false,
          child: Stack(
              children: [
                Consumer<FeedProvider>(
                  builder: (context, data, child) {

                    List<CommentResponseModel> models = data.commentModels;

                    return DraggableScrollableSheet(
                        expand: true,
                        initialChildSize: 0.6,
                        maxChildSize: 1.0,
                        builder: (BuildContext context, ScrollController scrollController) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                              border: Border.all(color: StaticColor.grey400BB, width: 1),
                            ),
                            child: Column(
                              children: [
                                /// comment header
                                SingleChildScrollView(
                                  physics: const ClampingScrollPhysics(),
                                  controller: scrollController,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // headerType,
                                      data.recommentMode == false
                                          ? CommentHeader(commentCount: data.commentModels.length, postId: widget.postId!)
                                          : RecommentHeader(postId: widget.postId!),
                                    ],
                                  ),
                                ),

                                /// comment list
                                data.recommentMode == true
                                    ? Expanded(child: ParentCommentField())
                                    : Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 100),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: models!.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Material(
                                              color: Colors.transparent,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    /// 답글로 전환
                                                    context.read<FeedProvider>().recommentModeChange(
                                                        true, models!.elementAt(index));
                                                  },
                                                  child: CommentPersonalRow(model: models!.elementAt(index), index: index)));
                                        },
                                      ),
                                    )
                                  // child: Container(color: Colors.red),
                                )
                              ],
                            ),
                          );
                        }
                    );
                  }
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: widget.bottomPadding!),
                    child: CommentInputField(postId: widget.postId!)),
                )
              ]
          ),
        ),
      ),
    );
  }
}