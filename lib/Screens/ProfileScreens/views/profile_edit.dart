import 'dart:io';
import 'dart:typed_data';

import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/components/form_input_text.dart';
import 'package:chinesequizapp/infrastructure/components/image_padding.dart';
import 'package:chinesequizapp/infrastructure/components/loading.dart';
import 'package:chinesequizapp/infrastructure/components/text_padding.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/account_repository.dart';
import 'package:chinesequizapp/infrastructure/utilities/custom_styles.dart';
import 'package:chinesequizapp/infrastructure/utilities/firebase_storage_utils.dart';
import 'package:chinesequizapp/infrastructure/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  bool isLoading = true;
  bool isProcessing = false;
  late Account account;
  final AccountRepository _accountRepository = AccountRepository();
  TextEditingController _nicknameController = TextEditingController();
  Uint8List? _image;

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

    _nicknameController.text = account.nickname ?? '';

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: TextButton(
          onPressed: () => Get.back(),
          style: CustomStyles.textButtonZeroSize(),
          child: ImagePadding(
            'arrow-left-app-bar-2.png',
            width: 24,
            height: 24,
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: isLoading ? Loading() : Stack(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 24), child: Column(
              children: [
                Expanded(child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => _getFromGallery(),
                        style: CustomStyles.textButtonZeroSize(),
                        child: Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              margin: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3,
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: _image != null ? Image.memory(
                                _image!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ) : account.profileUrl != null ? ImagePadding(
                                account.profileUrl!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                isNetwork: true,
                              ) : Container(),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: ImagePadding('profile-camera-2.png', width: 32, height: 32,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18,),
                  TextPadding('닉네임', fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff696A6F),),
                  SizedBox(height: 6,),
                  FormInputText(
                    controller: _nicknameController,
                    hintText: '닉네임을 입력해주세요.',
                    maxLength: 8,
                    fontSize: 14,
                    counterText: '',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xffEAEAEB),
                      ),
                    ),
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
                    onChanged: (e) => setState(() => {}),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextPadding('${_nicknameController.text.length}자 / 최대 8자', fontWeight: FontWeight.w500, fontSize: 11, color: Color(0xff525252),),
                    ],
                  ),
                ],),)),
                SizedBox(height: 16,),
                TextButton(
                  onPressed: () => _onSubmit(),
                  style: CustomStyles.textButtonZeroSize(),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff6518F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      '확인',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 16,),
              ],
            ),),
            if (isProcessing)...[
              Positioned.fill(child: Container(
                color: Colors.black.withOpacity(.6),
                child: Loading(color: Colors.white,),
              )),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _getFromGallery() async {
    File? imageFile = await Utils.pickImageFromGallery();
    if (imageFile != null) {
      setState(() => _image = imageFile.readAsBytesSync());
    }
  }

  Future<void> _onSubmit() async {
    if (isLoading) {
      Fluttertoast.showToast(msg: '사용자 정보를 불러오는 중입니다.\n잠시만 기다려주세요.');
      return;
    } else if (isProcessing) {
      Fluttertoast.showToast(msg: '정보 업로드 중입니다.\n잠시만 기다려주세요.');
      return;
    }

    String nickname = _nicknameController.text;
    if (nickname.isEmpty) {
      Fluttertoast.showToast(msg: '닉네임을 입력해주세요');
      return;
    }

    setState(() => isProcessing = true);
    Utils.hideKeyboard(context);

    String? downloadURL;
    Uint8List? image = _image;
    if (image != null) {
      String fileName = FirebaseStorageUtils.getUploadFileName();
      downloadURL = await FirebaseStorageUtils.uploadBytes(
        image,
        'profiles/$fileName',
      );
    }

    await _accountRepository.updateProfile(account.email!,
      nickname: nickname,
      profileUrl: downloadURL ?? account.profileUrl,
    );

    Fluttertoast.showToast(
        msg: '프로필 정보가 수정됐습니다.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.transparent,
        textColor: Colors.white,
        fontSize: 16.0);

    setState(() => isProcessing = false);
  }
}
