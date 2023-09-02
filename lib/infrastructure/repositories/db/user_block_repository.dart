import 'package:chinesequizapp/infrastructure/Constants/database_constants.dart';
import 'package:chinesequizapp/infrastructure/models/user_block.dart';
import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserBlockRepository {
  final String _userBlockCollection = DatabaseConstants.databaseUserBlockCollection;
  final QuizAppDatabaseService db = QuizAppDatabaseService.I;

  Future<List<UserBlock>> getUserBlocks({
    required String userEmail,
  }) async {
    List<Map<String, dynamic>>? list = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_userBlockCollection)
        .find(where.eq('userEmail', userEmail))
        .toList();

    if (list != null) {
      return list.map((e) => UserBlock.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<UserBlock>> getUserBlocksFirestore({
    required String userEmail,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(_userBlockCollection)
          .where('userEmail', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((e) => UserBlock.fromJson(e.data() as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }


  Future<UserBlock?> createUserBlock({
    required String userEmail,
    required String targetUserEmail,
    required DateTime createdAt,
  }) async {
    UserBlock community = UserBlock(
      id: await getUserBlockCreateId(),
      userEmail: userEmail,
      targetUserEmail: targetUserEmail,
      createdAt: createdAt,
    );

    final WriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_userBlockCollection)
        .insertOne(community.toJson());
    Map<String, Object?>? document = result?.document;
    if (document != null) {
      return UserBlock.fromJson(document);
    }

    return null;
  }

  Future<UserBlock?> createUserBlockFirestore({
    required String userEmail,
    required String targetUserEmail,
    required DateTime createdAt,
  }) async {
    UserBlock community = UserBlock(
      id: await getUserBlockCreateId(),
      userEmail: userEmail,
      targetUserEmail: targetUserEmail,
      createdAt: createdAt,
    );

    try {
      await FirebaseFirestore.instance
          .collection(_userBlockCollection)
          .doc(community.id.toString())
          .set(community.toJson());

      return community;
    } catch (e) {
      print(e);
      return null;
    }
  }


  Future<int> getUserBlockCreateId() async {
    Map<String, dynamic>? lastItem = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_userBlockCollection)
        .findOne(where.sortBy('_id', descending: true).limit(1));
    if (lastItem != null) {
      UserBlock lastUserBlock = UserBlock.fromJson(lastItem);
      return lastUserBlock.id + 1;
    }

    return 0;
  }

  Future<int> getUserBlockCreateIdFirestore() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance
        .collection(_userBlockCollection)
        .orderBy('_id', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      UserBlock lastUserBlock = UserBlock.fromJson(querySnapshot.docs[0].data() as Map<String, dynamic>);
      return lastUserBlock.id + 1;
    }

    return 0;
  }

}
