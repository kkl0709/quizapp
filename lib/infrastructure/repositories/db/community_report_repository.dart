import 'package:chinesequizapp/infrastructure/Constants/database_constants.dart';
import 'package:chinesequizapp/infrastructure/models/community_report.dart';
import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class CommunityReportRepository {
  final String _communityReportCollection = DatabaseConstants.databaseCommunityReportCollection;
  final QuizAppDatabaseService db = QuizAppDatabaseService.I;

  Future<List<CommunityReport>> getCommunityReports({
    required String userEmail,
  }) async {
    List<Map<String, dynamic>>? list = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_communityReportCollection)
        .find(where.eq('userEmail', userEmail))
        .toList();

    if (list != null) {
      return list.map((e) => CommunityReport.fromJson(e)).toList();
    }
    return [];
  }

  Future<CommunityReport?> createCommunityReport({
    required String userEmail,
    required int communityId,
    required DateTime createdAt,
  }) async {
    CommunityReport community = CommunityReport(
      id: await getCommunityReportCreateId(),
      userEmail: userEmail,
      communityId: communityId,
      createdAt: createdAt,
    );

    final WriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_communityReportCollection)
        .insertOne(community.toJson());
    Map<String, Object?>? document = result?.document;
    if (document != null) {
      return CommunityReport.fromJson(document);
    }

    return null;
  }

  Future<int> getCommunityReportCreateId() async {
    Map<String, dynamic>? lastItem = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_communityReportCollection)
        .findOne(where.sortBy('_id', descending: true).limit(1));
    if (lastItem != null) {
      CommunityReport lastCommunityReport = CommunityReport.fromJson(lastItem);
      return lastCommunityReport.id + 1;
    }

    return 0;
  }
}
