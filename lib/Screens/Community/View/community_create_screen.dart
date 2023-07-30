import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class CommunityCreateScreen extends StatefulWidget {
  @override
  _CommunityCreateScreenState createState() => _CommunityCreateScreenState();
}

class _CommunityCreateScreenState extends State<CommunityCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('게시글 작성', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: HexColor('#1E1F27')),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: HexColor('#1E1F27'),),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text('저장', style: TextStyle(fontSize: 16, color: HexColor('#ACACAF'), fontWeight: FontWeight.bold),)
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Expanded(
                  child: TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        hintText: '게시글 내용을 작성해주세요.\n욕설이나 비방은 이용이 제한될 수 있어요,',
                        hintStyle: TextStyle(color: HexColor('#ACACAF'), fontSize: 14),
                        border: InputBorder.none
                    ),
                  )
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: HexColor('#F0F0F1')
                        )
                    )
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.image, color: HexColor('#696A6F'),),
                      label: Text('사진등록', style: TextStyle(color: HexColor('#696A6F'), fontSize: 13),)
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

}