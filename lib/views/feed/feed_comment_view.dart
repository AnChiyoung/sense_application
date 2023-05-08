import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/feed/comment_model.dart';
import 'package:sense_flutter_application/public_widget/comment_like_button.dart';
import 'package:sense_flutter_application/public_widget/comment_subcomment_button.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/public_widget/get_widget_size.dart';
import 'package:sense_flutter_application/public_widget/overflow_text.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';

class CommentView extends StatefulWidget {
  double? topPadding;
  CommentView({Key? key, this.topPadding}) : super(key: key);

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
    print('how?? : $bottomSheetMaxHeight');

    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      maxChildSize: bottomSheetMaxHeight,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
            border: Border.all(color: StaticColor.grey400BB, width: 1),
            // border: Border(top: BorderSide(color: StaticColor.grey400BB, width: 0)),
          ),
          child: Consumer<FeedProvider>(
            builder: (context, data, child) => Stack(
              children: [
                bottomSheetHeader(),
                Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: CommentModel.description.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          commentField(context, index),
                          Divider(height: 0.1, color: Colors.grey),
                        ],
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: commentInputField(context, commentInputController)),
              ],
            ),
          ),
          // child: ListView.builder(
          //   itemCount: 2,
          //   itemBuilder: (context, index) {
          //     if(index == 0) {
          //       return bottomSheetHeader();
          //     } else {
          //       return ListView.builder(
          //         controller: scrollController,
          //         itemCount: 25,
          //         itemBuilder: (BuildContext context, int index) {
          //           return ListTile(title: Text('Item $index'));
          //         },
          //       );
          //     }
          //   }
          // )
        );
      },

    );
  }

  Widget commentField(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) { return Wrap(children: [myCommentBottomSheet(context, index)]);});
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// personal comment header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    EmptyUserProfile(),
                    const SizedBox(width: 8),
                    Text(CommentModel.name[index], style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 4),
                    Image.asset('assets/feed/comment_dot.png', width: 3, height: 3),
                    const SizedBox(width: 4),
                    Text(CommentModel.writeDateTime[index], style: TextStyle(fontSize: 14, color: StaticColor.grey400BB, fontWeight: FontWeight.w500)),
                  ],
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) { return Wrap(children: [reportBottomSheet(context, index)]);});
                    },
                    customBorder: const CircleBorder(),
                    child: Image.asset('assets/feed/comment_etc_icon.png', width: 24, height: 24),
                  )
                )
              ],
            ),
            /// personal comment description
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(CommentModel.description[index]),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 40),
            //   child: OverflowText(
            //       text: CommentModel.description[index], maxLength: 10)
            // ),
            /// personal comment like, subcomment field
            Consumer<FeedProvider>(
              builder: (context, data, child) => data.commentState == CommentModel.likeState[index] ? Padding(
                padding: const EdgeInsets.only(left: 40, top: 10, bottom: 12),
                child: Row(
                  children: [
                    CommentLikeButton(state: CommentModel.likeState[index], index: index),
                    const SizedBox(width: 4),
                    Text(CommentModel.likeCount[index].toString()),
                    const SizedBox(width: 16),
                    CommentButton(state: false),
                    const SizedBox(width: 4),
                    Text('0'),
                  ],
                ),
              ) : Padding(
                padding: const EdgeInsets.only(left: 40, top: 10, bottom: 12),
                child: Row(
                  children: [
                    CommentLikeButton(state: CommentModel.likeState[index], index: index),
                    const SizedBox(width: 4),
                    Text(CommentModel.likeCount[index].toString()),
                    const SizedBox(width: 16),
                    CommentButton(state: false),
                    const SizedBox(width: 4),
                    Text('0'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget myCommentBottomSheet(BuildContext context, [int? index]) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      child: Column(
        children: [
          /// title section
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 26, top: 24, bottom: 32),
            child: Text('신고', style: TextStyle(fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 64),
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(backgroundColor: StaticColor.errorBackgroundColor, elevation: 0.0),
                        child: Text('신고하기', style: TextStyle(fontSize: 14, color: StaticColor.textErrorColor, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(backgroundColor: StaticColor.errorBackgroundColor, elevation: 0.0),
                        child: Text('신고하기', style: TextStyle(fontSize: 14, color: StaticColor.textErrorColor, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget reportBottomSheet(BuildContext context, int index) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      child: Column(
        children: [
          /// title section
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 26, top: 24, bottom: 32),
            child: Text('신고', style: TextStyle(fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 64),
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(context: context, builder: (context) {
                              return reportDialog(context, index!);
                              // return Container(
                              //   color: Colors.transparent,
                              //   child: Container(
                              //     width: 100,
                              //     height: 100,
                              //     color: Colors.white,
                              //   )
                              // );
                            });
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: StaticColor.errorBackgroundColor, elevation: 0.0),
                          child: Text('신고하기', style: TextStyle(fontSize: 14, color: StaticColor.textErrorColor, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget reportDialog(BuildContext context, int index) {

    final reasonState = context.watch<FeedProvider>().reportReason;

    return Dialog(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
          ),
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
                        context.read<FeedProvider>().reportReasonStateChange([true, false, false, false, false]);
                      },
                      child: Row(
                        children: [
                          reasonState[0] == false ? Image.asset('assets/feed/report_checkbox_empty.png', width: 20, height: 20) : Image.asset('assets/feed/report_checkbox_fill.png', width: 20, height: 20),
                          const SizedBox(width: 8),
                          Text('욕설/비방', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        context.read<FeedProvider>().reportReasonStateChange([false, true, false, false, false]);
                      },
                      child: Row(
                        children: [
                          reasonState[1] == false ? Image.asset('assets/feed/report_checkbox_empty.png', width: 20, height: 20) : Image.asset('assets/feed/report_checkbox_fill.png', width: 20, height: 20),
                          const SizedBox(width: 8),
                          Text('홍보/불법광고', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        context.read<FeedProvider>().reportReasonStateChange([false, false, true, false, false]);
                      },
                      child: Row(
                        children: [
                          reasonState[2] == false ? Image.asset('assets/feed/report_checkbox_empty.png', width: 20, height: 20) : Image.asset('assets/feed/report_checkbox_fill.png', width: 20, height: 20),
                          const SizedBox(width: 8),
                          Text('음란물/선정적인 게시물', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        context.read<FeedProvider>().reportReasonStateChange([false, false, false, true, false]);
                      },
                      child: Row(
                        children: [
                          reasonState[3] == false ? Image.asset('assets/feed/report_checkbox_empty.png', width: 20, height: 20) : Image.asset('assets/feed/report_checkbox_fill.png', width: 20, height: 20),
                          const SizedBox(width: 8),
                          Text('정치적인 게시물', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        context.read<FeedProvider>().reportReasonStateChange([false, false, false, false, true]);
                      },
                      child: Row(
                        children: [
                          reasonState[4] == false ? Image.asset('assets/feed/report_checkbox_empty.png', width: 20, height: 20) : Image.asset('assets/feed/report_checkbox_fill.png', width: 20, height: 20),
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
                    Container(
                      height: 80,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: StaticColor.grey100F6,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: TextFormField(
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        maxLines: 100,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: '내용을 입력해 주세요',
                          hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                          border: InputBorder.none,
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
                                style: ElevatedButton.styleFrom(backgroundColor: StaticColor.grey100F6, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
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
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: reasonState.contains(true) == true ? StaticColor.mainSoft : StaticColor.grey400BB, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
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
        ),
    );
  }

  Widget bottomSheetHeader([int? commentCount]) {

    return MeasureSize(
      onChange: (Size size) {
        setState(() {
          childSize = size.height;
        });
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 12),
            child: Center(
              child: Image.asset('assets/feed/comment_header_bar.png', width: 75, height: 4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('댓글', style: TextStyle(fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
                    const SizedBox(width: 4),
                    Text(CommentModel.description.length.toString(), style: TextStyle(fontSize: 12, color: StaticColor.grey60077, fontWeight: FontWeight.w400)),
                  ],
                ),
                Consumer<FeedProvider>(
                  builder: (context, data, child) => Row(
                    children: [
                      data.sortState[0] == false ? const SizedBox.shrink() : Image.asset('assets/feed/comment_sort_check_icon.png', width: 16, height: 16),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          context.read<FeedProvider>().sortStateChange([true, false]);
                        },
                        child: Text('인기순',
                            style: TextStyle(
                                fontSize: 12,
                                color: data.sortState[0] == false ? StaticColor.grey60077 : StaticColor.black90015,
                                fontWeight: data.sortState[0] == false ? FontWeight.w400 : FontWeight.w500))),
                      const SizedBox(width: 8),
                      data.sortState[1] == false ? const SizedBox.shrink() : Image.asset('assets/feed/comment_sort_check_icon.png', width: 16, height: 16),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          context.read<FeedProvider>().sortStateChange([false, true]);
                        },
                        child: Text('최신순',
                            style: TextStyle(
                                fontSize: 12,
                                color: data.sortState[1] == false ? StaticColor.grey60077 : StaticColor.black90015,
                                fontWeight: data.sortState[1] == false ? FontWeight.w400 : FontWeight.w500))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: StaticColor.grey300E0,
          ),
        ],
      ),
    );
  }

  Widget commentInputField(BuildContext context, TextEditingController controller) {
    return Container(
      height: 76,
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
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              EmptyUserProfile(),
              const SizedBox(width: 8),
              Expanded(
                  child: Container(
                    height: 32,
                    color: StaticColor.grey100F6,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: commentInputController,
                      autofocus: true,
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: '댓글 입력',
                        hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                        border: InputBorder.none,
                        alignLabelWithHint: true,
                      ),
                      onFieldSubmitted: (value) {
                        CommentModel.description.add(commentInputController.text);
                        CommentModel.profileImage.add('');
                        CommentModel.name.add('엘리예요');
                        CommentModel.writeDateTime.add('방금');
                        CommentModel.likeCount.add(0);
                        CommentModel.likeState.add(false);
                        CommentModel.subCommentCount.add(0);
                        context.read<FeedProvider>().commentFieldUpdateChange(true);
                      },
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
