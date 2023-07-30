import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:chinesequizapp/infrastructure/components/image_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/Constants/font_constants.dart';


class LectureDetailScreen extends StatefulWidget {
  const LectureDetailScreen({Key? key}) : super(key: key);

  @override
  State<LectureDetailScreen> createState() => _LectureDetailScreenState();
}

class _LectureDetailScreenState extends State<LectureDetailScreen> {
  dynamic lecture;
  int activeIndex = 0;
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse('https://media.w3.org/2010/05/sintel/trailer.mp4'))
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  Widget build(BuildContext context) {
    lecture = ModalRoute.of(context)!.settings.arguments;

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
                child: Text(
                  lecture['title'],
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text(
              '제1강.\n테트라란 무엇인가',
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
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  bool isActive = index == activeIndex;

                  return Column(
                    children: [
                      if (index > 0)...[
                        SizedBox(height: 10,),
                      ],
                      Padding(
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
                                '1강. 테트라란 무엇인가?',
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
                                '₩9,900',
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