import 'package:chinesequizapp/infrastructure/Constants/database_constants.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class CommunityIndexScreen extends StatefulWidget {
  @override
  _CommunityIndexScreenState createState() => _CommunityIndexScreenState();
}

class _CommunityIndexScreenState extends State<CommunityIndexScreen> {
  final String? _collection = DatabaseConstants.databaseQuestionsCollection;
  final QuizAppDatabaseService db = QuizAppDatabaseService.I;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('커뮤니티', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
            ),
            SizedBox(height: 24,),
            Expanded(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(RoutesConstants.communityDetailScreen);
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
                                          Image(image: AssetImage('assets/images/dummy.png'), width: 40, height: 40,),
                                          SizedBox(width: 8,),
                                          Text('abc@abc.com', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),)
                                        ],
                                      ),
                                      IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz), color: HexColor('#ACACAF'),)
                                    ],
                                  ),
                                  Container(
                                    child: Text('teststsetstse', style: TextStyle(fontSize: 14, color: HexColor('#696A6F')), textAlign: TextAlign.left,),
                                  ),
                                  SizedBox(height: 8,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton.icon(
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero
                                        ),
                                        onPressed: () {},
                                        icon: Image(image: AssetImage('assets/images/comment.png'), width: 24, height: 24,),
                                        label: Text('댓글달기', style: TextStyle(fontSize: 12, color: HexColor('#696A6F')),),
                                      ),
                                      Text('2023.10.10', style: TextStyle(color: HexColor('#696A6F'), fontSize: 12),)
                                    ],
                                  )
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
                  itemCount: 10,
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RoutesConstants.communityCreateScreen);
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}