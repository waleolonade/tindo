import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Show_Post/controllers/CommentScreenController.dart';

import '../../../data/Model/RelateScreen_Model/RelateScreeen_Comment.dart';

class CommentScreen extends StatefulWidget {
  final String postID;
  final int index;
  final int postScreenType;
  const CommentScreen({Key? key, required this.postID, required this.index, required this.postScreenType})
      : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  CommentScreenController commentScreenController = Get.put(CommentScreenController());

  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    commentScreenController.getUserlist(widget.postID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: ImageIcon(
                      const AssetImage(
                        "Images/new_dis/back.png",
                      ),
                      size: 25,
                      color: ThemeColor.blackback,
                    ),
                  ),
                  const SizedBox(
                    width: 26,
                  ),
                  Text(
                    "Comments",
                    style: TextStyle(fontFamily: 'abold', fontSize: 18.5, color: ThemeColor.blackback),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => (commentScreenController.isLoding.value)
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(color: ThemeColor.pink),
                      ),
                    )
                  : (relatesCommentData.isEmpty)
                      ? Expanded(
                          child: Center(
                            child: Image.asset(
                              AppImages.nodataImage,
                              height: 200,
                              width: 200,
                            ),
                          ),
                        )
                      : Expanded(
                          child: SizedBox(
                            child: GetBuilder<CommentScreenController>(
                              builder: (controller) => ListView.separated(
                                controller: commentScreenController.scrollController,
                                shrinkWrap: true,
                                itemCount: relatesCommentData.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: Colors.grey,
                                                  backgroundImage:
                                                      NetworkImage(relatesCommentData[index].userProfile),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      relatesCommentData[index].userName,
                                                      style: TextStyle(
                                                        fontFamily: 'abold',
                                                        fontSize: 15,
                                                        color: ThemeColor.blackback,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    ConstrainedBox(
                                                      constraints: BoxConstraints(maxWidth: Get.width - 100),
                                                      child: Text(
                                                        relatesCommentData[index].userDiscription,
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                          color: ThemeColor.graylight,
                                                          fontSize: 14,
                                                          fontFamily: 'amidum',
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          top: 5,
                                          right: 15,
                                          child: Text(
                                            relatesCommentData[index].date,
                                            style: TextStyle(
                                              fontFamily: 'amidum',
                                              fontSize: 10,
                                              color: ThemeColor.graylight,
                                            ),
                                          ))
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 5,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: ThemeColor.greAlpha20,
                    width: 1.2,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 50),
                      child: Container(
                        width: Get.width / 1.26,
                        alignment: Alignment.center,
                        child: TextFormField(
                          maxLines: 3,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          controller: commentScreenController.commentfield,
                          cursorColor: ThemeColor.pink,
                          focusNode: _focusNode,
                          style: TextStyle(
                            color: ThemeColor.blackback,
                            fontSize: 14,
                            fontFamily: 'amidum',
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                              top: 15,
                              bottom: 15,
                              left: 12,
                              right: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Say something..",
                            hintStyle: TextStyle(color: ThemeColor.grayIcon, fontSize: 14),
                            filled: true,
                            fillColor: ThemeColor.greAlpha20.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          commentScreenController.sendComment(
                              postId: widget.postID, index: widget.index, postScreenType: widget.postScreenType);
                          commentScreenController.commentfield.clear();
                          _focusNode.unfocus();
                        });
                      },
                      child: SizedBox(
                        height: 40,
                        child: Image.asset("Images/Home/ic_send.PNG"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
