import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/feed/comment_model.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';
import 'package:sense_flutter_application/views/feed_improve/feed_bottom_field.dart';
import 'package:sense_flutter_application/views/feed_improve/feed_comment_header.dart';
import 'package:sense_flutter_application/views/feed_improve/feed_comment_row.dart';

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

    List<CommentResponseModel> commentModelList = context.watch<FeedProvider>().commentModels;
    int commentCount = commentModelList.length;

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
                DraggableScrollableSheet(
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
                                  CommentHeader(commentCount: commentCount, postId: widget.postId!),
                                ],
                              ),
                            ),

                            /// comment list
                            commentModelList == null ? const SizedBox.shrink() :
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 100),
                                child: ListView.builder(

                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: commentModelList!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return CommentPersonalRow(model: commentModelList.elementAt(index), index: index);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        // child: Stack(
                        //   children: [
                        //     CommentArea(controller: scrollController, editingController: commentInputController, postId: widget.postId),
                        //     Align(
                        //         alignment: Alignment.bottomCenter,
                        //         child: commentInputField(context, commentInputController)),
                        //
                        //     /// comment request
                        //     Consumer<FeedProvider>(
                        //       builder: (context, data, child) => data.recommentMode == true
                        //         ? FutureBuilder(
                        //             future: CommentRequest().commentRequest(widget.postId!, data.sortState.toString()),
                        //             builder: (context, snapshot) {
                        //               if(snapshot.hasError) {
                        //                 return Container();
                        //               } else if(snapshot.hasData) {
                        //                 List<CommentResponseModel>? commentModels = snapshot.data!.elementAt(0);
                        //                 int commentCount = snapshot.data!.elementAt(1);
                        //                 return Column(
                        //                   mainAxisSize: MainAxisSize.min,
                        //                   children: [
                        //                     bottomSheetHeader(context),
                        //                     Padding(
                        //                       padding: const EdgeInsets.only(bottom: 85),
                        //                       child: RecommentView(commentModel: data.selectComment)
                        //                     ),
                        //                   ],
                        //                 );
                        //               } else {
                        //                 return Container();
                        //               }
                        //             }
                        //           )
                        //         :
                        //     ),
                        //   ],
                        // ),
                      );
                    }
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: widget.bottomPadding!),
                    child: CommentInputField()),
                )
              ]
          ),
        ),
      ),
    );
  }
}