import 'package:chinesequizapp/Screens/QuestionScreen/controller/questions_controller.dart';
import 'package:chinesequizapp/Screens/QuestionScreen/controller/result_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultCard extends StatelessWidget {
  final int index;

  const ResultCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    int index_1 = 0;
    int index_2 = 0;
    if (index == 0) {
      index_1 = 14;
      index_2 = 8;
    }
    if (index == 1) {
      index_1 = 8;
      index_2 = 3;
    }
    if (index == 2) {
      index_1 = 3;
      index_2 = 6;
    }
    if (index == 3) {
      index_1 = 2;
      index_2 = 6;
    }
    if (index == 4) {
      index_1 = 2;
    }

    return Container(
        margin: EdgeInsets.only(top: 20, bottom: index == 4 ? 20 : 0),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.black, // 검정색 배경
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Center(
                child: Text(
                  'Process ${index + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GetBuilder<QuestionsController>(
              builder: (controller) => index != 4
                  ? Text("questionScreen_result_${index}_0".tr +
                      controller.listTEC[index_1].text +
                      "questionScreen_result_${index}_1".tr +
                      controller.listTEC[index_2].text +
                      "questionScreen_result_${index}_2".tr)
                  : Text("questionScreen_result_${index}_0".tr + controller.listTEC[index_1].text + "questionScreen_result_${index}_1".tr),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ));
  }
}

class BasicResult extends StatelessWidget {
  const BasicResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          AlphabetBox(alphabet: 'o'),
          TextBox(text: '자신에게 못준다'),
          Icon(Icons.arrow_forward_outlined),
          AlphabetBox(alphabet: 'i'),
          TextBox(text: '부모에게 못받는다'),
          Icon(Icons.arrow_forward_outlined),
          AlphabetBox(alphabet: 'd'),
          TextBox(text: '동반자에게 받는다'),
          Icon(Icons.arrow_forward_outlined),
          AlphabetBox(alphabet: 'g'),
          TextBox(text: '자신에게 준다'),
          Icon(Icons.arrow_forward_outlined),
          AlphabetBox(alphabet: 'c'),
          TextBox(text: '자신에게 받는다'),
        ],
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFFEEEEEE),
          width: 1,
        ),
      ),
    );
  }
}

class AlphabetBox extends StatelessWidget {
  final String alphabet;

  const AlphabetBox({
    super.key,
    required this.alphabet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      // 고정된 너비
      height: 30,
      // 고정된 높이
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.black, // 검정색 배경
        shape: BoxShape.circle, // 둥근 모양
      ),
      child: Center(
        child: Text(
          alphabet,
          textAlign: TextAlign.center, // 텍스트를 중앙 정렬
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  final String text;

  const TextBox({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFF1E1F27),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
