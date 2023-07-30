import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/components/image_padding.dart';
import 'package:chinesequizapp/infrastructure/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/Constants/font_constants.dart';

class LectureScreen extends StatefulWidget {
  const LectureScreen({Key? key}) : super(key: key);

  @override
  State<LectureScreen> createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  late List<dynamic> lectureList;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    lectureList = List.filled(5, {}).map((e) => {
      'id': 1,
      'imgUrl': 'https://images.unsplash.com/photo-1606761568499-6d2451b23c66?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1674&q=80',
      'title': '1강. 테트라란 무엇인가?',
      'price': 9900,
    }).toList();
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
              SizedBox(height: 20,),
              Expanded(
                child: ListView.builder(
                  itemCount: lectureList.length,
                  itemBuilder: (BuildContext context, int index) {
                    dynamic lecture = lectureList[index];

                    return Column(
                      children: [
                        if (index > 0)...[
                          SizedBox(height: 12,),
                        ],
                        GestureDetector(
                          onTap: () => Get.toNamed(RoutesConstants.lectureDetailScreen, arguments: lecture),
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
