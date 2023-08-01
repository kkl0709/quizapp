import 'package:chinesequizapp/infrastructure/components/image_padding.dart';
import 'package:chinesequizapp/infrastructure/components/text_padding.dart';
import 'package:chinesequizapp/infrastructure/utilities/custom_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomModals {
  static void showCommunityEtc(BuildContext context, {
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ImagePadding('modal-tab.png', width: 37.5, height: 4, padding: EdgeInsets.symmetric(vertical: 10),),
                      const SizedBox(height: 13,),
                      TextButton(
                        onPressed: () {
                          Get.back();
                          showDoubleButtonPopup(
                            title: '게시물을 수정하시겠어요?',
                            leftText: '취소',
                            rightText: '확인',
                            onPressedRB: () => onEdit(),
                          );
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                          child: Text(
                            '게시물 수정',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xff616161)),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                          showDoubleButtonPopup(
                            title: '게시물을 삭제하시겠어요?',
                            leftText: '취소',
                            rightText: '확인',
                            onPressedRB: () => onDelete(),
                          );
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                          child: Text(
                            '게시물 삭제',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xff616161)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static void showDoubleButtonPopup({
    required String title,
    required String leftText,
    required String rightText,
    Color rightTextColor = Colors.black,
    FontWeight rightTextFontWeight = FontWeight.w900,
    VoidCallback? onPressedLB,
    required VoidCallback onPressedRB,
  }) {
    showDialog(
        context: Get.context!,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24,),
                TextPadding(title, fontWeight: FontWeight.w700, fontSize: 18, color: Color(0xff1E1F27), padding: EdgeInsets.symmetric(horizontal: 24),),
                SizedBox(height: 24,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Flexible(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                if (onPressedLB != null) onPressedLB();
                              },
                              style: CustomStyles.textButtonZeroSize(),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff696A6F),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    leftText,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8,),
                          Flexible(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                onPressedRB();
                              },
                              style: CustomStyles.textButtonZeroSize(),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff321646),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    rightText,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 28,),
              ],
            ),
            scrollable: true,
          );
        }
    );
  }

  static void showCommunityCommentEtc(BuildContext context, {
    required VoidCallback onDelete,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ImagePadding('modal-tab.png', width: 37.5, height: 4, padding: EdgeInsets.symmetric(vertical: 10),),
                      const SizedBox(height: 13,),
                      TextButton(
                        onPressed: () {
                          Get.back();
                          showDoubleButtonPopup(
                            title: '댓글을 삭제하시겠어요?',
                            leftText: '취소',
                            rightText: '확인',
                            onPressedRB: () => onDelete(),
                          );
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                          child: Text(
                            '댓글 삭제',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xff616161)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}