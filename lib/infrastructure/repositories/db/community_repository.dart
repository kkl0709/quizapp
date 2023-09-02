import 'package:chinesequizapp/infrastructure/Constants/database_constants.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/models/community.dart';
import 'package:chinesequizapp/infrastructure/models/communityComment.dart';
import 'package:chinesequizapp/infrastructure/models/communityComment.dart';
import 'package:chinesequizapp/infrastructure/models/community_report.dart';
import 'package:chinesequizapp/infrastructure/models/user_block.dart';
import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/account_repository.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/community_report_repository.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/user_block_repository.dart';
import 'package:get/utils.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityRepository {
  final String _communityCollection = DatabaseConstants.databaseCommunityCollection;
  final String _commentCollection = DatabaseConstants.databaseCommunityCommentsCollection;
  final CollectionReference _communityCollectionFirestore =
      FirebaseFirestore.instance.collection(DatabaseConstants.databaseCommunityCollection);
  final CollectionReference _commentCollectionFirestore =
      FirebaseFirestore.instance.collection(DatabaseConstants.databaseCommunityCommentsCollection);

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

  Future<Community?> createCommunityFirestore({
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

    await _communityCollectionFirestore.doc(community.id.toString()).set(community.toJson());
    return community;
  }

  Future<Community?> updateCommunity(Community community) async {
    await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_communityCollection)
        .replaceOne(where.eq('_id', community.id), community.toJson());
    return community;
  }

  Future<Community?> updateCommunityFirestore(Community community) async {
    await _communityCollectionFirestore.doc(community.id.toString()).set(community.toJson());
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

  Future<int> getCommunityCreateIdFirestore() async {
    QuerySnapshot querySnapshot =
        await _communityCollectionFirestore.orderBy('_id', descending: true).limit(1).get();
    if (querySnapshot.docs.isNotEmpty) {
      Community lastCommunity = Community.fromJson(querySnapshot.docs[0].data() as Map<String, dynamic>);
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

  Future<int> getCommentCreateIdFirestore() async {
    QuerySnapshot? lastItem =
        (await _commentCollectionFirestore.orderBy('_id', descending: true).limit(1).get());
    if (lastItem.docs.isNotEmpty) {
      CommunityComment lastCommunity =
          CommunityComment.fromJson(lastItem.docs[0].data() as Map<String, dynamic>);
      return lastCommunity.id + 1;
    }
    return 0;
  }

  Future<List<Community>> getCommunities({
    required String userEmail,
  }) async {
    List<Map<String, dynamic>>? list = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_communityCollection)
        .find(where.sortBy('_id', descending: true))
        .toList();
    if (list != null) {
      List<Community> communities = list.map((e) => Community.fromJson(e)).toList();
      List<Account> accounts = await AccountRepository().getAccounts();
      communities = communities.map((e) {
        e.account = accounts.firstWhereOrNull((account) => account.email == e.userEmail);
        return e;
      }).toList();

      // 사용자 차단 여부 확인
      List<UserBlock> userBlocks = await UserBlockRepository().getUserBlocks(
        userEmail: userEmail,
      );
      communities = communities
          .where((e) => userBlocks.indexWhere((userBlock) => userBlock.targetUserEmail == e.userEmail) < 0)
          .toList();

      // 게시글 신고 여부 확인
      List<CommunityReport> communityReports = await CommunityReportRepository().getCommunityReports(
        userEmail: userEmail,
      );
      communities = communities
          .where((e) =>
              communityReports.indexWhere((communityReport) => communityReport.communityId == e.id) < 0)
          .toList();

      return communities;
    }

    return [];
  }

  Future<List<Community>> getCommunitiesFirestore({
    required String userEmail,
  }) async {
    QuerySnapshot querySnapshot = await _communityCollectionFirestore.orderBy('_id', descending: true).get();
    List<Community> communities =
        querySnapshot.docs.map((e) => Community.fromJson(e.data() as Map<String, dynamic>)).toList();

    List<Account> accounts = await AccountRepository().getAccounts();
    communities = communities.map((e) {
      e.account = accounts.firstWhereOrNull((account) => account.email == e.userEmail);
      return e;
    }).toList();

    // 사용자 차단 여부 확인
    List<UserBlock> userBlocks = await UserBlockRepository().getUserBlocks(userEmail: userEmail);
    communities = communities
        .where((e) => userBlocks.indexWhere((userBlock) => userBlock.targetUserEmail == e.userEmail) < 0)
        .toList();

    // 게시글 신고 여부 확인
    List<CommunityReport> communityReports =
        await CommunityReportRepository().getCommunityReports(userEmail: userEmail);
    communities = communities
        .where(
            (e) => communityReports.indexWhere((communityReport) => communityReport.communityId == e.id) < 0)
        .toList();

    return communities;
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

  Future<CommunityComment?> createCommunityCommentFirestore({
    required int communityId,
    required int userAuthType,
    required String userEmail,
    required String contents,
    required DateTime createdAt,
  }) async {
    CommunityComment comment = CommunityComment(
      id: await getCommentCreateId(),
      communityId: communityId,
      userAuthType: userAuthType,
      userEmail: userEmail,
      contents: contents,
      createdAt: createdAt,
    );

    DocumentReference docRef = await _commentCollectionFirestore.add(comment.toJson());
    DocumentSnapshot docSnap = await docRef.get();
    if (docSnap.exists) {
      return CommunityComment.fromJson(docSnap.data() as Map<String, dynamic>);
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
      List<CommunityComment> comments = list.map((e) => CommunityComment.fromJson(e)).toList();
      List<Account> accounts = await AccountRepository().getAccounts();
      comments = comments.map((e) {
        e.account = accounts.firstWhereOrNull((account) => account.email == e.userEmail);
        return e;
      }).toList();
      return comments;
    }

    return [];
  }

  Future<List<CommunityComment>> getCommunityCommentsFirestore({
    required int communityId,
  }) async {
    QuerySnapshot querySnapshot = await _commentCollectionFirestore
        .where('communityId', isEqualTo: communityId)
        .orderBy('_id', descending: true)
        .get();
    List<CommunityComment> comments =
        querySnapshot.docs.map((e) => CommunityComment.fromJson(e.data() as Map<String, dynamic>)).toList();
    List<Account> accounts = await AccountRepository().getAccounts();
    comments = comments.map((e) {
      e.account = accounts.firstWhereOrNull((account) => account.email == e.userEmail);
      return e;
    }).toList();

    return comments;
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

  Future<bool> deleteCommunityFirestore({
    required int id,
  }) async {
    await deleteCommunityCommentByCommunityId(communityId: id);
    await _communityCollectionFirestore.doc(id.toString()).delete();

    return true; // Firestore에서는 성공 여부를 직접 확인하는 방법이 없으므로, 호출이 성공적으로 완료되면 항상 true를 반환합니다.
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

  Future<bool> deleteCommunityCommentByCommunityIdFirestore({
    required int communityId,
  }) async {
    QuerySnapshot comments =
        await _commentCollectionFirestore.where('communityId', isEqualTo: communityId).get();
    for (QueryDocumentSnapshot doc in comments.docs) {
      await _commentCollectionFirestore.doc(doc.id).delete();
    }

    return true;
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

  Future<bool> deleteCommunityCommentFirestore({
    required int id,
  }) async {
    await _commentCollectionFirestore.doc(id.toString()).delete();
    return true;
  }
}
