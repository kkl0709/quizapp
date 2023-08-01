import 'dart:io';
import 'dart:typed_data';

import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/components/custom_modals.dart';
import 'package:chinesequizapp/infrastructure/components/image_padding.dart';
import 'package:chinesequizapp/infrastructure/components/loading.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/models/community.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/account_repository.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/community_repository.dart';
import 'package:chinesequizapp/infrastructure/utilities/firebase_storage_utils.dart';
import 'package:chinesequizapp/infrastructure/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class CommunityCreateScreen extends StatefulWidget {
  @override
  _CommunityCreateScreenState createState() => _CommunityCreateScreenState();
}

class _CommunityCreateScreenState extends State<CommunityCreateScreen> {
  bool isLoading = true;
  bool isProcessing = false;
  late Account account;
  final AccountRepository _accountRepository = AccountRepository();
  TextEditingController _contentsController = TextEditingController();
  Uint8List? _image;
  Community? _updateCommunity;

  @override
  void initState() {
    super.initState();
    _initData();
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
    this.account = account;

    Future.delayed(Duration.zero, () {
      Community? community = ModalRoute.of(context)!.settings.arguments as Community?;
      if (community != null) {
        _contentsController.text = community.contents;
      }
      _updateCommunity = community;
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('게시글 작성', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: HexColor('#1E1F27')),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: HexColor('#1E1F27'),),
            onPressed: () => _onBackPressed(),
          ),
          actions: [
            TextButton(
                onPressed: () => _onSave(),
                child: Text('저장', style: TextStyle(fontSize: 16, color: _contentsController.text.isNotEmpty ? HexColor('#321646') : HexColor('#ACACAF'), fontWeight: FontWeight.bold),)
            ),
          ],
        ),
        body: SafeArea(
          child: isLoading ? Loading() : Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        if (_image == null && _updateCommunity?.imgUrl == null) {
                          return _widgetTextField();
                        } else {
                          Widget widgetImage;
                          if (_image != null) {
                            widgetImage = Image.memory(
                              _image!,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            );
                          } else {
                            widgetImage = ImagePadding(
                              _updateCommunity!.imgUrl!,
                              width: double.infinity,
                              fit: BoxFit.contain,
                              isNetwork: true,
                            );
                          }

                          return Column(
                            children: [
                              Expanded(child: _widgetTextField()),
                              SizedBox(height: 16,),
                              Expanded(child: SingleChildScrollView(
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Color(0xffF0F0F1)),
                                      ),
                                      margin: EdgeInsets.symmetric(horizontal: 20),
                                      clipBehavior: Clip.antiAlias,
                                      child: widgetImage,
                                    ),
                                    Positioned(
                                      top: 16,
                                      right: 16 + 20,
                                      child: TextButton(
                                        onPressed: () => _removeImage(),
                                        style: TextButton.styleFrom(
                                          minimumSize: Size.zero,
                                          padding: EdgeInsets.zero,
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: ImagePadding(
                                          'close.png',
                                          width: 24,
                                          height: 24,
                                          padding: EdgeInsets.all(5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: HexColor('#F0F0F1'),
                        ),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                          onPressed: () => _getFromGallery(),
                          icon: Icon(Icons.image, color: HexColor('#696A6F'),),
                          label: Text('사진등록', style: TextStyle(color: HexColor('#696A6F'), fontSize: 13),)
                      ),
                    ),
                  ),
                ],
              ),
              if (isProcessing)...[
                Positioned.fill(child: Container(
                  color: Colors.black.withOpacity(.6),
                  child: Loading(color: Colors.white,),
                )),
              ],
            ],
          ),
        ),
      ),
      onWillPop: () async {
        _onBackPressed();
        return false;
      },
    );
  }

  Future<void> _getFromGallery() async {
    File? imageFile = await Utils.pickImageFromGallery();
    if (imageFile != null) {
      setState(() => _image = imageFile.readAsBytesSync());
    }
  }

  Widget _widgetTextField() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          maxLines: null,
          controller: _contentsController,
          keyboardType: TextInputType.multiline,
          onChanged: (msg) => setState(() => {}),
          decoration: InputDecoration(
            hintText: '게시글 내용을 작성해주세요.\n욕설이나 비방은 이용이 제한될 수 있어요,',
            hintStyle: TextStyle(color: HexColor('#ACACAF'), fontSize: 14),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    if (isLoading) {
      Fluttertoast.showToast(msg: '게시글 정보를 불러오는 중입니다.\n잠시만 기다려주세요.');
      return;
    } else if (isProcessing) {
      Fluttertoast.showToast(msg: '업로드 중입니다.\n잠시만 기다려주세요.');
      return;
    }

    String contents = _contentsController.text;
    if (contents.isEmpty) {
      Fluttertoast.showToast(msg: '내용을 입력해주세요');
      return;
    }

    setState(() => isProcessing = true);

    String? downloadURL;
    Uint8List? image = _image;
    if (image != null) {
      String fileName = FirebaseStorageUtils.getUploadFileName();
      downloadURL = await FirebaseStorageUtils.uploadBytes(
        image,
        'communities/$fileName',
      );
    }

    Community? savedCommunity;
    Community? updateCommunity = _updateCommunity;
    if (updateCommunity == null) {
      savedCommunity = await CommunityRepository().createCommunity(
        userAuthType: account.authType!,
        userEmail: account.email!,
        imgUrl: downloadURL,
        contents: contents,
        createdAt: DateTime.now(),
      );
    } else {
      updateCommunity.contents = contents;
      if (downloadURL != null) updateCommunity.imgUrl = downloadURL;
      savedCommunity = await CommunityRepository().updateCommunity(updateCommunity);
    }

    String actionStr = updateCommunity == null ? '생성' : '수정';
    if (savedCommunity != null) {
      Fluttertoast.showToast(msg: '게시글이 $actionStr되었습니다.');
      Get.back(result: savedCommunity);
    } else {
      Fluttertoast.showToast(msg: '게시글 $actionStr 중 오류가 발생하였습니다.');
    }

    setState(() => isProcessing = false);
  }

  void _removeImage() {
    if (_image != null) {
      setState(() => _image = null);
    } else {
      setState(() => _updateCommunity!.imgUrl = null);
    }
  }

  void _onBackPressed() {
    if (_updateCommunity == null) {
      if (_contentsController.text.isNotEmpty || _image != null) {
        CustomModals.showDoubleButtonPopup(
          title: '뒤로가기를 누르면\n작성하던 글이 삭제돼요!',
          leftText: '취소',
          rightText: '확인',
          onPressedRB: () => Get.back(),
        );
        return;
      }
    }

    Get.back();
  }
}