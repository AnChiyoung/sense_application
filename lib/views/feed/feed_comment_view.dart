import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/feed/comment_model.dart';
import 'package:sense_flutter_application/models/feed/feed_detail_model.dart';
import 'package:sense_flutter_application/models/feed/report_model.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/public_widget/comment_delete_dialog.dart';
import 'package:sense_flutter_application/public_widget/comment_like_button.dart';
import 'package:sense_flutter_application/public_widget/comment_subcomment_button.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/public_widget/get_widget_size.dart';
import 'package:sense_flutter_application/public_widget/overflow_text.dart';
import 'package:sense_flutter_application/public_widget/report_finish.dart';
import 'package:sense_flutter_application/views/feed/feed_comment_area.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';
import 'package:sense_flutter_application/views/feed/feed_recomment_view.dart';

class CommentView extends StatefulWidget {
  int? postId;
  double? topPadding;
  int? commentCount;
  CommentView({Key? key, this.postId, this.topPadding, this.commentCount}) : super(key: key);

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {

  TextEditingController commentInputController = TextEditingController();
  double childSize = 0.0;

  double getBottomSheetMaxHeight(BuildContext context, double topPadding) {
    return (MediaQuery.of(context).size.height - topPadding) / MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {

    double bottomSheetMaxHeight = getBottomSheetMaxHeight(context, widget.topPadding!);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
              border: Border.all(color: StaticColor.grey400BB, width: 1),
            ),
            child: Stack(
              children: [
                CommentArea(controller: scrollController, editingController: commentInputController, postId: widget.postId),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: commentInputField(context, commentInputController)),

                // /// comment request
                // Consumer<FeedProvider>(
                //   builder: (context, data, child) => data.recommentMode == true
                //     ? FutureBuilder(
                //         future: CommentRequest().commentRequest(widget.postId!, data.sortState.toString()),
                //         builder: (context, snapshot) {
                //           if(snapshot.hasError) {
                //             return Container();
                //           } else if(snapshot.hasData) {
                //             List<CommentResponseModel>? commentModels = snapshot.data!.elementAt(0);
                //             int commentCount = snapshot.data!.elementAt(1);
                //             return Column(
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 bottomSheetHeader(context),
                //                 Padding(
                //                   padding: const EdgeInsets.only(bottom: 85),
                //                   child: RecommentView(commentModel: data.selectComment)
                //                 ),
                //               ],
                //             );
                //           } else {
                //             return Container();
                //           }
                //         }
                //       )
                //     :
                // ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget commentInputField(BuildContext context, TextEditingController controller) {

    bool isRegedit = false;

    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: StaticColor.grey400BB,
            blurRadius: 1,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: Consumer<FeedProvider>(
          builder: (context, data, child) => Row(
            children: [
              UserProfileImage(profileImageUrl: PresentUserInfo.profileImage ?? ''),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 32,
                  color: StaticColor.grey100F6,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: commentInputController,
                    autofocus: true,
                    cursorColor: Colors.black,
                    cursorHeight: 15,
                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: data.inputMode == 0 ? '댓글 입력' : '답글 입력',
                      hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                      alignLabelWithHint: true,
                    ),
                    onChanged: (value) {
                      if(value.isNotEmpty) {
                        if(value.trim() == '') {

                        } else {
                          isRegedit = true;
                          context.read<FeedProvider>().inputButtonStateChange(true);
                        }
                      } else {
                        isRegedit = false;
                        context.read<FeedProvider>().inputButtonStateChange(false);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Material(
                color: Colors.transparent,
                child: InkWell(
                    borderRadius: BorderRadius.circular(25.0),
                    // onTap: () {
                    onTap: () async {
                      CommentResponseModel responseModel = CommentResponseModel();
                      bool updateResult = false;
                      /// 댓글
                      if(data.inputMode == 0) {
                        /// 공백이나 스페이스 입력 시에는 등록 x
                        if(isRegedit == true) {
                          responseModel = await CommentRequest().commentWriteRequest(widget.postId!, commentInputController.text);
                        }

                        if(responseModel == CommentResponseModel() || responseModel == null) {}
                        else {
                          context.read<FeedProvider>().inputButtonStateChange(false);
                          context.read<FeedProvider>().feedDetailModelInitialize(
                              responseModel.postBottomInfo!.isCommented,
                              responseModel.postBottomInfo!.commentCount,
                              responseModel.postBottomInfo!.isLiked,
                              responseModel.postBottomInfo!.likeCount
                          );
                          context.read<FeedProvider>().commentModelRequest(widget.postId!, context.read<FeedProvider>().sortState);
                          commentInputController.text = '';
                          isRegedit = false;
                        }
                      }
                      /// 답글
                      else if(data.inputMode == 1) {

                      }
                      /// 수정
                      else if(data.inputMode == 2) {
                        if(isRegedit == true) {
                          updateResult = await CommentRequest().commentUpdateRequest(widget.postId!, commentInputController.text);
                        }
                        if(updateResult == true) {
                          context.read<FeedProvider>().inputButtonStateChange(false);
                          context.read<FeedProvider>().commentModelRequest(context.read<FeedProvider>().selectCommentId, context.read<FeedProvider>().sortState);
                          context.read<FeedProvider>().inputModeChange(0);
                          commentInputController.text = '';
                          isRegedit = false;
                        } else {
                          context.read<FeedProvider>().inputButtonStateChange(false);
                          context.read<FeedProvider>().inputModeChange(0);
                          commentInputController.text = '';
                          isRegedit = false;
                        }
                      }











                      // if(data.inputMode == true) {
                      //   /// 여기 수정
                      //   // bool inputRecommentResult = await CommentRequest().recommentWriteRequest(data.selectComment!.id!, commentInputController.text);
                      //   // inputRecommentResult == true
                      //   //     ? {
                      //   //         context.read<FeedProvider>().inputButtonStateChange(false),
                      //   //         context.read<FeedProvider>().recommentFieldUpdateChange(true),
                      //   //         commentInputController.text = ''}
                      //   //     : {};
                      // } else
                    },
                    child: Consumer<FeedProvider>(
                      builder: (context, data, child) => Center(child: Image.asset('assets/feed/comment_regedit.png', width: 24, height: 24, color: data.inputButton == true ? StaticColor.mainSoft : StaticColor.grey400BB))),
                    )

              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReportDialog extends StatefulWidget {
  int? index;
  ReportDialog({Key? key, this.index}) : super(key: key);

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {

  int selectReportIndex = 0;
  List<bool> selectType = [false, false, false, false, false];
  TextEditingController reportDescription = TextEditingController();

  void dialogCallback() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      insetPadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      content: Builder(
        builder: (context) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Text('신고하기', style: TextStyle(fontSize: 16, color: StaticColor.black90015, fontWeight: FontWeight.w500))
                ),
                Container(
                    height: 1,
                    color: StaticColor.grey300E0
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('사유를 선택해주세요', style: TextStyle(fontSize: 14, color: StaticColor.black90015, fontWeight: FontWeight.w700))),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectReportIndex = 0;
                            selectType[0] = !selectType[0];
                          });
                        },
                        child: Row(
                          children: [
                            selectType[0] == false ? Image.asset('assets/feed/report_checkbox_empty.png', width: 20, height: 20) : Image.asset('assets/feed/report_checkbox_fill.png', width: 20, height: 20),
                            const SizedBox(width: 8),
                            Text('욕설/비방', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectReportIndex = 1;
                            selectType[1] = !selectType[1];
                          });
                        },
                        child: Row(
                          children: [
                            selectType[1] == false ? Image.asset('assets/feed/report_checkbox_empty.png', width: 20, height: 20) : Image.asset('assets/feed/report_checkbox_fill.png', width: 20, height: 20),
                            const SizedBox(width: 8),
                            Text('홍보/불법광고', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectReportIndex = 2;
                            selectType[2] = !selectType[2];
                          });
                        },
                        child: Row(
                          children: [
                            selectType[2] == false ? Image.asset('assets/feed/report_checkbox_empty.png', width: 20, height: 20) : Image.asset('assets/feed/report_checkbox_fill.png', width: 20, height: 20),
                            const SizedBox(width: 8),
                            Text('음란물/선정적인 게시물', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectReportIndex = 3;
                            selectType[3] = !selectType[3];
                          });
                        },
                        child: Row(
                          children: [
                            selectType[3] == false ? Image.asset('assets/feed/report_checkbox_empty.png', width: 20, height: 20) : Image.asset('assets/feed/report_checkbox_fill.png', width: 20, height: 20),
                            const SizedBox(width: 8),
                            Text('정치적인 게시물', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectReportIndex = 4;
                            selectType[4] = !selectType[4];
                          });
                        },
                        child: Row(
                          children: [
                            selectType[4] == false ? Image.asset('assets/feed/report_checkbox_empty.png', width: 20, height: 20) : Image.asset('assets/feed/report_checkbox_fill.png', width: 20, height: 20),
                            const SizedBox(width: 8),
                            Text('기타', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('상세내용을 입력하세요', style: TextStyle(fontSize: 14, color: StaticColor.black90015, fontWeight: FontWeight.w700))),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        height: 120,
                        child: TextFormField(
                          autofocus: false,
                          maxLength: 90,
                          controller: reportDescription,
                          textInputAction: TextInputAction.next,
                          maxLines: 100,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: '내용을 입력해 주세요',
                            hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: StaticColor.textFormFieldFillColor,
                            alignLabelWithHint: true,
                            errorText: null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.grey100F6, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)), elevation: 0.0),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 40, child: Center(child: Text('취소하기', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w700)))),
                                      ]
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    List<int> sendReportIndex = [];
                                    bool reportRequestResult = false;
                                    selectType.contains(true) == true ?
                                        {
                                          List.generate(selectType.length, (index) => selectType.elementAt(index) == true ? sendReportIndex.add(index) : {}),
                                          reportRequestResult = await ReportRequest().reportRequest(sendReportIndex, reportDescription.text ?? '', widget.index!),
                                          if(reportRequestResult == true) {
                                            Navigator.of(context).pop(),
                                            showDialog(
                                              context: context,
                                              //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return ReportFinish(reportRequest: true);
                                              }
                                            ),
                                          }
                                          else {
                                            Navigator.of(context).pop(),
                                            showDialog(
                                                context: context,
                                                //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                                                barrierDismissible: false,
                                                builder: (BuildContext context) {
                                                  return ReportFinish(reportRequest: false);
                                                }
                                            ),
                                          }
                                        } : {};
                                    print(sendReportIndex);
                                    // Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: selectType.contains(true) == true ? StaticColor.mainSoft : StaticColor.grey400BB, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)), elevation: 0.0),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 40, child: Center(child: Text('신고하기', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700)))),
                                      ]
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

