import 'package:chinesequizapp/Screens/LectureScreens/controller/lecture_screen_controller.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/components/image_padding.dart';
import 'package:chinesequizapp/infrastructure/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/Constants/app_constants_color.dart';
import '../../../infrastructure/Constants/font_constants.dart';

class LectureScreen extends GetView<LectureScreenController> {
  const LectureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.bgColor.value,
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
                SizedBox(height: 20,),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.lectureList.length,
                    itemBuilder: (BuildContext context, int index) {
                      dynamic lecture = controller.lectureList[index];

                      return Column(
                        children: [
                          if (index > 0)...[
                            SizedBox(height: 12,),
                          ],
                          Container(
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
                                        Positioned.fill(child: ImagePadding(
                                          lecture['imgUrl'],
                                          isNetwork: true,
                                          fit: BoxFit.cover,
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16,),
                                Row(
                                  children: [
                                    ImagePadding('play.png', width: 24, height: 24, fit: BoxFit.contain,),
                                    SizedBox(width: 8,),
                                    Expanded(child: Text(
                                      lecture['title'],
                                      style: TextStyle(
                                        fontFamily: FontsConstants.sourceSerifProRegular,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Color(0xff1E1F27),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                    SizedBox(width: 8,),
                                    Text(
                                      '₩${Utils.numberFormat(lecture['price'])}',
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
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
