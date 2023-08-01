import 'package:chinesequizapp/infrastructure/Constants/database_constants.dart';
import 'package:chinesequizapp/infrastructure/models/community.dart';
import 'package:chinesequizapp/infrastructure/models/communityComment.dart';
import 'package:chinesequizapp/infrastructure/models/communityComment.dart';
import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class CommunityRepository {
  final String _communityCollection = DatabaseConstants.databaseCommunityCollection;
  final String _commentCollection = DatabaseConstants.databaseCommunityCommentsCollection;
  final QuizAppDatabaseService db = QuizAppDatabaseService.I;

  Future<Community?> createCommunity({
    required int userAuthType,
    required String userEmail,
    required String? imgUrl,
    required String contents,
    required DateTime createdAt,
  }) async {
    Community community = Community(
      id: await getCommunityCreateId(),
      userAuthType: userAuthType,
      userEmail: userEmail,
      imgUrl: imgUrl,
      contents: contents,
      createdAt: createdAt,
    );

    final WriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_communityCollection)
        .insertOne(community.toJson());
    Map<String, Object?>? document = result?.document;
    if (document != null) {
      return Community.fromJson(document);
    }

    return null;
  }

  Future<Community?> updateCommunity(Community community) async {
    await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_communityCollection)
        .replaceOne(where.eq('_id', community.id), community.toJson());
    return community;
  }

  Future<int> getCommunityCreateId() async {
    Map<String, dynamic>? lastItem = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_communityCollection)
        .findOne(where.sortBy('_id', descending: true).limit(1));
    if (lastItem != null) {
      Community lastCommunity = Community.fromJson(lastItem);
      return lastCommunity.id + 1;
    }

    return 0;
  }

  Future<int> getCommentCreateId() async {
    Map<String, dynamic>? lastItem = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_commentCollection)
        .findOne(where.sortBy('_id', descending: true).limit(1));
    if (lastItem != null) {
      CommunityComment lastCommunity = CommunityComment.fromJson(lastItem);
      return lastCommunity.id + 1;
    }

    return 0;
  }

  Future<List<Community>> getCommunities() async {
    List<Map<String, dynamic>>? list = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_communityCollection)
        .find(where.sortBy('_id', descending: true))
        .toList();
    if (list != null) {
      return list.map((e) => Community.fromJson(e)).toList();
    }

    return [];
  }

  Future<CommunityComment?> createCommunityComment({
    required int communityId,
    required int userAuthType,
    required String userEmail,
    required String contents,
    required DateTime createdAt,
  }) async {
    CommunityComment community = CommunityComment(
      id: await getCommentCreateId(),
      communityId: communityId,
      userAuthType: userAuthType,
      userEmail: userEmail,
      contents: contents,
      createdAt: createdAt,
    );

    final WriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_commentCollection)
        .insertOne(community.toJson());
    Map<String, Object?>? document = result?.document;
    if (document != null) {
      return CommunityComment.fromJson(document);
    }

    return null;
  }

  Future<List<CommunityComment>> getCommunityComments({
    required int communityId,
  }) async {
    List<Map<String, dynamic>>? list = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_commentCollection)
        .find(where.eq('communityId', communityId).sortBy('_id', descending: true))
        .toList();
    if (list != null) {
      return list.map((e) => CommunityComment.fromJson(e)).toList();
    }

    return [];
  }

  Future<bool> deleteCommunity({
    required int id,
  }) async {
    await deleteCommunityCommentByCommunityId(communityId: id);

    final WriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_communityCollection)
        .deleteOne(where.eq('_id', id));
    return result?.isSuccess ?? false;
  }

  Future<bool> deleteCommunityCommentByCommunityId({
    required int communityId,
  }) async {
    final WriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_commentCollection)
        .deleteMany(where.eq('communityId', communityId));
    return result?.isSuccess ?? false;
  }

  Future<bool> deleteCommunityComment({
    required int id,
  }) async {
    final WriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_commentCollection)
        .deleteMany(where.eq('_id', id));
    return result?.isSuccess ?? false;
  }
}
