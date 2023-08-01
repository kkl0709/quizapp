import 'package:appinio_video_player/appinio_video_player.dart';
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


class LectureDetailScreen extends StatefulWidget {
  const LectureDetailScreen({Key? key}) : super(key: key);

  @override
  State<LectureDetailScreen> createState() => _LectureDetailScreenState();
}

class _LectureDetailScreenState extends State<LectureDetailScreen> {
  bool isLoading = true;
  late Account account;
  late Lecture lecture;
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
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
    this.account = account;

    lectureList = await LectureRepository().getLectures();

    Future.delayed(Duration.zero, () {
      lecture = ModalRoute.of(context)!.settings.arguments as Lecture;
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(lecture.videoUrl))..initialize().then((value) => setState(() {}));
      _customVideoPlayerController = CustomVideoPlayerController(
        context: context,
        videoPlayerController: videoPlayerController,
      );

      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 56,
        title: SizedBox(
          width: double.infinity,
          height: 56,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Color(0xff1E1F27),),
                onPressed: () => Get.back(),
              ),
              Expanded(
                child: isLoading ? Loading(size: 10,) : Text(
                  lecture.title,
                  style: TextStyle(
                    fontFamily: FontsConstants.sourceSerifProBold,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xff1E1F27),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              Opacity(opacity: 0, child: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Color(0xff1E1F27),),
                onPressed: () => {},
              ),)
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: isLoading ? Loading() : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text(
              '제${lecture.number}강.\n${lecture.title}',
              style: TextStyle(
                fontFamily: FontsConstants.sourceSerifProBold,
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Color(0xff1E1F27),
              ),
            ),),
            SizedBox(height: 24,),
            AspectRatio(
              aspectRatio: 375 / 210,
              child: Container(
                color: Color(0xffD9D9D9),
                child: CustomVideoPlayer(
                  customVideoPlayerController: _customVideoPlayerController,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: lectureList.length,
                itemBuilder: (BuildContext context, int index) {
                  Lecture lectureItem = lectureList[index];
                  bool isActive = lectureItem.id == lecture.id;

                  return Column(
                    children: [
                      if (index > 0)...[
                        SizedBox(height: 10,),
                      ],
                      GestureDetector(
                        onTap: () => Get.offAndToNamed(RoutesConstants.lectureDetailScreen, arguments: lectureItem),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isActive ? Color(0xff1E1F27) : Color(0xffFBFBFC),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                            child: Row(
                              children: [
                                ImagePadding('play.png', width: 24, height: 24, fit: BoxFit.contain, color: isActive ? Colors.white : null,),
                                SizedBox(width: 9,),
                                Expanded(child: Text(
                                  '${lectureItem.number}강. ${lectureItem.title}',
                                  style: TextStyle(
                                    fontFamily: FontsConstants.sourceSerifProBold,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: isActive ? Colors.white : Color(0xff1E1F27),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                                SizedBox(width: 8,),
                                Text(
                                  '₩${Utils.numberFormat(lectureItem.price)}',
                                  style: TextStyle(
                                    fontFamily: FontsConstants.sourceSerifProRegular,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Color(0xff696A6F),
                                  ),
                                ),
                              ],
                            ),
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
    );
  }
}