import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class CommunityDetailScreen extends StatefulWidget {
  @override
  _CommunityDetailScreenState createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('댓글', style: TextStyle(color: HexColor('#1E1F27'), fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: HexColor('#1E1F27'),),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 66),
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 16),
                          child: Column(
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
                                child: Text('sss'),
                              ),
                              Image(image: AssetImage('assets/images/dummy_board.png')),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('2023.10.10', style: TextStyle(color: HexColor('#696A6F'), fontSize: 12))
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
                      Column(
                        children: [
                          Container(
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
                                  CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/dummy.png'),
                                    radius: 20,
                                  ),
                                  SizedBox(width: 8,),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('이름', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text('2023.10.10', style: TextStyle(color: HexColor('#ACACAF'), fontSize: 12),),
                                                  IconButton(
                                                      style: IconButton.styleFrom(
                                                          padding: EdgeInsets.zero
                                                      ),
                                                      onPressed: () {},
                                                      icon: Icon(Icons.more_horiz, color: HexColor('#ACACAF'))
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Text('testtesttest', style: TextStyle(color: HexColor('#696A6F'), fontSize: 12),)
                                        ],
                                      )
                                  )
                                ],
                              )
                          ),
                          Container(
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
                                  CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/dummy.png'),
                                    radius: 20,
                                  ),
                                  SizedBox(width: 8,),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('이름', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text('2023.10.10', style: TextStyle(color: HexColor('#ACACAF'), fontSize: 12),),
                                                  IconButton(
                                                      style: IconButton.styleFrom(
                                                          padding: EdgeInsets.zero
                                                      ),
                                                      onPressed: () {},
                                                      icon: Icon(Icons.more_horiz, color: HexColor('#ACACAF'))
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Text('testtesttest', style: TextStyle(color: HexColor('#696A6F'), fontSize: 12),)
                                        ],
                                      )
                                  )
                                ],
                              )
                          )
                        ],
                      )
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
                      color: Colors.white
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: '댓글을 입력해주세요...',
                                hintStyle: TextStyle(color: HexColor('#A3A3A3'), fontSize: 13),
                                contentPadding: EdgeInsets.only(left: 20, right: 20),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        color: HexColor('#E5E5E5')
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        color: HexColor('#E5E5E5')
                                    )
                                ),
                              )
                          )
                      ),
                      SizedBox(width: 10,),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: HexColor('#321646').withOpacity(0.5),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                            onPressed: () {},
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
}