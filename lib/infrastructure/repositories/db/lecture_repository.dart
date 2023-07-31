import 'package:chinesequizapp/infrastructure/Constants/database_constants.dart';
import 'package:chinesequizapp/infrastructure/models/lecture.dart';
import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';
import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

class LectureRepository {
  final String _collection = DatabaseConstants.databaseLectureCollection;
  final QuizAppDatabaseService db = QuizAppDatabaseService.I;

  Future<DatabaseResp> createLecture(Lecture lecture) async {
    final WriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .insertOne(lecture.toJson());
    if (result?.document != null) {
      return DatabaseResp.success(data: Lecture.fromJson(result!.document!));
    } else {
      return DatabaseResp.error(error: DbRespError.registrationFailed);
    }
  }

  Future<bool> createLectures(List<Lecture> lectures) async {
    final BulkWriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .insertMany(lectures.map((e) => e.toJson()).toList());
    return result?.isSuccess ?? false;
  }

  Future<List<Lecture>> getLectures() async {
    List<Map<String, dynamic>>? list = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .find(where.sortBy('number'))
        .toList();
    if (list != null) {
      return list.map((e) => Lecture.fromJson(e)).toList();
    }

    return [];
  }

  Future<List<Lecture>> initLectureSample() async {
    debugPrint('initLectureSample()');
    bool isSuccess = await createLectures(List.generate(10, (index) => Lecture(
      id: index,
      imgUrl: 'https://images.unsplash.com/photo-1606761568499-6d2451b23c66?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1674&q=80',
      videoUrl: 'https://firebasestorage.googleapis.com/v0/b/tetra-56730.appspot.com/o/lectures%2Ftest_video.mp4?alt=media&token=42060ef6-b555-45aa-91ce-629ad23cf780',
      number: index + 1,
      title: '테트라란 무엇인가?',
      price: 9900,
      createdAt: DateTime.now(),
    )));
    debugPrint('initLectureSample() - isSuccess: $isSuccess');

    return await getLectures();
  }
}
