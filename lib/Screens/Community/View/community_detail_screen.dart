import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/components/custom_modals.dart';
import 'package:chinesequizapp/infrastructure/components/image_padding.dart';
import 'package:chinesequizapp/infrastructure/components/loading.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/models/community.dart';
import 'package:chinesequizapp/infrastructure/models/communityComment.dart';
import 'package:chinesequizapp/infrastructure/models/community_report.dart';
import 'package:chinesequizapp/infrastructure/models/user_block.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/account_repository.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/community_report_repository.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/community_repository.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/user_block_repository.dart';
import 'package:chinesequizapp/infrastructure/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class CommunityDetailScreen extends StatefulWidget {
  @override
  _CommunityDetailScreenState createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
  bool isLoading = true;
  bool isLoadingComments = true;
  late Community community;
  late Account account;
  List<CommunityComment> communityCommentList = [];
  TextEditingController commentController = TextEditingController();
  FocusNode commentFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _refreshData() async {
    setState(() => {
      isLoading = true,
      isLoadingComments = true,
    });
    await _initData();
  }

  Future<void> _initData() async {
    String email = await SharedPreferenceService.getLoggedInEmail;
    Account? account;
    if (email.isNotEmpty) {
      final resp = await AccountRepository().getAccountByEmail(email);
      if (resp.data is Account) {
        account = resp.data;
      }
    }
    if (account == null) {
      Fluttertoast.showToast(msg: '회원 정보를 불러올 수 없습니다.');
      return;
    }
    this.account = account;

    Future.delayed(Duration.zero, () {
      Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      community = arguments['community'] as Community;
      bool isOpenComment = arguments['isOpenComment'] as bool;
      setState(() => isLoading = false);

      _initComments(isOpenComment: isOpenComment);
    });
  }

  Future<void> _initComments({
    bool isOpenComment = false,
  }) async {
    setState(() => isLoadingComments = true);

    communityCommentList = await CommunityRepository().getCommunityComments(
      communityId: community.id,
    );

    setState(() => isLoadingComments = false);

    if (isOpenComment) {
      commentFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('댓글', style: TextStyle(color: HexColor('#1E1F27'), fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: HexColor('#1E1F27'),),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
          child: isLoading ? Loading() : Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 66),
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: ImagePadding(
                                          community.account?.profileUrl ?? 'dummy.png',
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                          isNetwork: community.account?.profileUrl != null,
                                        ),
                                      ),
                                      SizedBox(width: 8,),
                                      Text(community.userEmail, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),)
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (isMyCommunity()) {
                                        CustomModals.showCommunityEtc(context,
                                          onEdit: () async {
                                            dynamic result = await Get.toNamed(RoutesConstants.communityCreateScreen, arguments: community);
                                            if (result != null && result.runtimeType == Community) {
                                              _refreshData();
                                            }
                                          },
                                          onDelete: () async {
                                            bool isSuccess = await CommunityRepository().deleteCommunity(id: community.id);
                                            if (isSuccess) {
                                              Fluttertoast.showToast(msg: '삭제되었습니다.');
                                              Get.back(result: true);
                                            } else {
                                              Fluttertoast.showToast(msg: '삭제 중 오류가 발생하였습니다.');
                                            }
                                          },
                                        );
                                      } else {
                                        CustomModals.showCommunityReport(context,
                                          onUserBlock: () async {
                                            UserBlock? userBlock = await UserBlockRepository().createUserBlock(
                                              userEmail: account.email!,
                                              targetUserEmail: community.userEmail,
                                              createdAt: DateTime.now(),
                                            );
                                            if (userBlock != null) {
                                              Fluttertoast.showToast(msg: '해당 사용자를 차단하였습니다.');
                                              Get.back(result: true);
                                            } else {
                                              Fluttertoast.showToast(msg: '차단 중 오류가 발생하였습니다.');
                                            }
                                          },
                                          onReport: () async {
                                            CommunityReport? communityReport = await CommunityReportRepository().createCommunityReport(
                                              userEmail: account.email!,
                                              communityId: community.id,
                                              createdAt: DateTime.now(),
                                            );
                                            if (communityReport != null) {
                                              Fluttertoast.showToast(msg: '해당 게시글을 신고하였습니다.');
                                              Get.back(result: true);
                                            } else {
                                              Fluttertoast.showToast(msg: '신고 중 오류가 발생하였습니다.');
                                            }
                                          },
                                        );
                                      }
                                    },
                                    icon: Icon(Icons.more_horiz),
                                    color: HexColor('#ACACAF'),
                                  ),
                                ],
                              ),
                              Container(
                                child: Text(community.contents, textAlign: TextAlign.start,),
                              ),
                              if (community.imgUrl != null)...[
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Color(0xffF0F0F1)),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: ImagePadding(
                                    community.imgUrl!,
                                    width: double.infinity,
                                    isNetwork: true,
                                  ),
                                )
                              ],
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(DateFormat('yyyy.MM.dd').format(community.createdAt), style: TextStyle(color: HexColor('#696A6F'), fontSize: 12))
                              )
                            ],
                          )
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: HexColor('#F0F0F1'),
                        ),
                        height: 6,
                      ),
                      if (isLoadingComments)...[
                        Loading(),
                      ]else...[
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: communityCommentList.length,
                          itemBuilder: (BuildContext context, int index) {
                            CommunityComment item = communityCommentList[index];

                            return Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: HexColor('#F0F0F1')
                                        )
                                    )
                                ),
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 20, right: 20, bottom: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: ImagePadding(
                                        item.account?.profileUrl ?? 'dummy.png',
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                        isNetwork: item.account?.profileUrl != null,
                                      ),
                                    ),
                                    SizedBox(width: 8,),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(item.userEmail, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text(DateFormat('yyyy.MM.dd').format(item.createdAt), style: TextStyle(color: HexColor('#ACACAF'), fontSize: 12),),
                                                    if (isLoadingComments == false && item.userAuthType == account.authType && item.userEmail == account.email)...[
                                                      IconButton(
                                                          style: IconButton.styleFrom(
                                                              padding: EdgeInsets.zero
                                                          ),
                                                          onPressed: () => CustomModals.showCommunityCommentEtc(context,
                                                            onDelete: () async {
                                                              bool isSuccess = await CommunityRepository().deleteCommunityComment(id: item.id);
                                                              if (isSuccess) {
                                                                Fluttertoast.showToast(msg: '삭제되었습니다.');
                                                                _initComments();
                                                              } else {
                                                                Fluttertoast.showToast(msg: '삭제 중 오류가 발생하였습니다.');
                                                              }
                                                            },
                                                          ),
                                                          icon: Icon(Icons.more_horiz, color: HexColor('#ACACAF'))
                                                      )
                                                    ],
                                                  ],
                                                )
                                              ],
                                            ),
                                            Text(item.contents, style: TextStyle(color: HexColor('#696A6F'), fontSize: 12),)
                                          ],
                                        )
                                    )
                                  ],
                                )
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                      height: 66,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                                controller: commentController,
                                focusNode: commentFocusNode,
                                maxLines: 1,
                                onChanged: (m) => setState(() => {}),
                                decoration: InputDecoration(
                                  hintText: '댓글을 입력해주세요...',
                                  hintStyle: TextStyle(color: HexColor('#A3A3A3'), fontSize: 13),
                                  contentPadding: EdgeInsets.only(left: 20, right: 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        color: HexColor('#E5E5E5')
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                          color: HexColor('#E5E5E5')
                                      )
                                  ),
                                )
                            ),
                          ),
                          SizedBox(width: 10,),
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: HexColor('#321646').withOpacity(commentController.text.isEmpty ? 0.5 : 1),
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => _onCommentSubmit(),
                                icon: Icon(Icons.arrow_upward, color: Colors.white,)
                            ),
                          )
                        ],
                      )
                  )
              )
            ],
          )
      ),
    );
  }

  Future<void> _onCommentSubmit() async {
    if (isLoadingComments) {
      Fluttertoast.showToast(msg: '댓글 동기화 중입니다.\n잠시 후 다시 시도해주세요.');
      return;
    }

    String comment = commentController.text;
    if (comment.isEmpty) {
      Fluttertoast.showToast(msg: '댓글을 입력해주세요.');
      return;
    }

    Utils.hideKeyboard(context);

    setState(() => isLoadingComments = true);

    CommunityComment? createdCommunityComment = await CommunityRepository().createCommunityComment(
      communityId: community.id,
      userAuthType: account.authType!,
      userEmail: account.email!,
      contents: comment,
      createdAt: DateTime.now(),
    );

    if (createdCommunityComment != null) {
      commentController.text = '';
      debugPrint('createdCommunityComment: ${createdCommunityComment.toJson()}');
      Fluttertoast.showToast(msg: '댓글을 작성하였습니다.');
    } else {
      Fluttertoast.showToast(msg: '댓글 작성 중 오류가 발생하였습니다.');
    }

    await _initComments();
  }

  bool isMyCommunity() {
    return isLoading == false
        && community.userAuthType == account.authType
        && community.userEmail == account.email;
  }
}