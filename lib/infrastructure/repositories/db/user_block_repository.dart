import 'package:chinesequizapp/infrastructure/Constants/database_constants.dart';
import 'package:chinesequizapp/infrastructure/models/user_block.dart';
import 'package:chinesequizapp/infrastructure/repositories/database.dart';
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
}
