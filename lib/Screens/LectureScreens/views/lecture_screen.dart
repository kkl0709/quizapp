import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/components/image_padding.dart';
import 'package:chinesequizapp/infrastructure/components/loading.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/models/lecture.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/account_repository.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/lecture_repository.dart';
import 'package:chinesequizapp/infrastructure/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../infrastructure/Constants/font_constants.dart';

class LectureScreen extends StatefulWidget {
  const LectureScreen({Key? key}) : super(key: key);

  @override
  State<LectureScreen> createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  bool isLoading = true;
  late Rx<Account> account;
  final AccountRepository _accountRepository = AccountRepository();
  List<Lecture> lectureList = [];

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

    lectureList = await LectureRepository().getLectures();
    debugPrint('lectureList length: ${lectureList.length}');
    if (lectureList.isEmpty) {
      lectureList = await LectureRepository().initLectureSample();
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '인강보기',
                style: TextStyle(
                  fontFamily: FontsConstants.sourceSerifProRegular,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Color(0xff1e1f27),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: isLoading
                    ? Loading()
                    : ListView.builder(
                        itemCount: lectureList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Lecture lecture = lectureList[index];

                          return Column(
                            children: [
                              if (index > 0) ...[
                                SizedBox(
                                  height: 12,
                                ),
                              ],
                              GestureDetector(
                                onTap: () {
                                  if (Utils.userModel.isPurchase) {
                                    Get.toNamed(RoutesConstants.lectureDetailScreen, arguments: lecture);
                                  } else {
                                    Utils.showMessage(context, message: '강의를 결제해주세요');
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFAFAFA),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.only(top: 24, right: 20, bottom: 28, left: 20),
                                  child: Column(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 295 / 166,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffD9D9D9),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                  child: ImagePadding(
                                                lecture.imgUrl,
                                                isNetwork: true,
                                                fit: BoxFit.cover,
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          ImagePadding(
                                            'play.png',
                                            width: 24,
                                            height: 24,
                                            fit: BoxFit.contain,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                              child: Text(
                                            '${lecture.number}강. ${lecture.title}',
                                            style: TextStyle(
                                              fontFamily: FontsConstants.sourceSerifProRegular,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: Color(0xff1E1F27),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            '₩${Utils.numberFormat(lecture.price)}',
                                            style: TextStyle(
                                              fontFamily: FontsConstants.sourceSerifProRegular,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                              color: Color(0xff696A6F),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
