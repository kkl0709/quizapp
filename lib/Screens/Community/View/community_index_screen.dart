import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/components/image_padding.dart';
import 'package:chinesequizapp/infrastructure/components/loading.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/models/community.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/account_repository.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/community_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class CommunityIndexScreen extends StatefulWidget {
  @override
  _CommunityIndexScreenState createState() => _CommunityIndexScreenState();
}

class _CommunityIndexScreenState extends State<CommunityIndexScreen> {
  bool isLoading = true;
  late Rx<Account> account;
  final AccountRepository _accountRepository = AccountRepository();
  List<Community> communityList = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _refreshData() async {
    setState(() => isLoading = true);
    await _initData();
  }

  Future<void> _initData() async {
    String email = await SharedPreferenceService.getLoggedInEmail;
    Account? account;
    if (email.isNotEmpty) {
      final resp = await _accountRepository.getAccountByEmail(email);
      if (resp.data is Account) {
        account = resp.data;
      }
    }
    if (account == null) {
      Fluttertoast.showToast(msg: '회원 정보를 불러올 수 없습니다.');
      return;
    }

    communityList = await CommunityRepository().getCommunities();
    debugPrint('communityList length: ${communityList.length}');

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('커뮤니티', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
            ),
            SizedBox(height: 24,),
            if (isLoading)...[
              Loading(),
            ]else...[
              Expanded(
                  child: ListView.separated(
                    itemCount: communityList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Community community = communityList[index];

                        return InkWell(
                          onTap: () async {
                            dynamic result = await Get.toNamed(RoutesConstants.communityDetailScreen, arguments: {
                              'community': community,
                              'isOpenComment': false,
                            });
                            if (result != null) {
                              _refreshData();
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
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
                                        IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz), color: HexColor('#ACACAF'),)
                                      ],
                                    ),
                                    Container(
                                      child: Text(community.contents, style: TextStyle(fontSize: 14, color: HexColor('#696A6F')), textAlign: TextAlign.left,),
                                    ),
                                    SizedBox(height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton.icon(
                                          style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero
                                          ),
                                          onPressed: () async {
                                            dynamic result = await Get.toNamed(RoutesConstants.communityDetailScreen, arguments: {
                                              'community': community,
                                              'isOpenComment': true,
                                            });
                                            if (result != null) {
                                              _refreshData();
                                            }
                                          },
                                          icon: Image(image: AssetImage('assets/images/comment.png'), width: 24, height: 24,),
                                          label: Text('댓글달기', style: TextStyle(fontSize: 12, color: HexColor('#696A6F')),),
                                        ),
                                        Text(DateFormat('yyyy.MM.dd').format(community.createdAt), style: TextStyle(color: HexColor('#696A6F'), fontSize: 12),)
                                      ],
                                    ),
                                  ],
                                ),
                              )
                          ),
                        );
                      },
                    separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: HexColor('#F0F0F1'),
                          ),
                          height: 10,
                        );
                    },
                  )
              )
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dynamic result = await Get.toNamed(RoutesConstants.communityCreateScreen);
          if (result != null && result.runtimeType == Community) {
            _refreshData();
          }
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}