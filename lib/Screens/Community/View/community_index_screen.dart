import 'package:flutter/material.dart';

class CommunityIndexScreen extends StatefulWidget {
  @override
  _CommunityIndexScreen createState() => _CommunityIndexScreen();
}

class _CommunityIndexScreen extends State<CommunityIndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Text('커뮤니티', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
              Expanded(
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Container();
                      }
                  )
              )
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: Icon(Icons.edit),
      ),
    );
  }
}