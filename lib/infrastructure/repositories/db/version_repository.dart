import 'package:chinesequizapp/infrastructure/Constants/database_constants.dart';
import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';
import 'package:chinesequizapp/infrastructure/models/version.dart';
import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VersionRepository {
  final String _collection = DatabaseConstants.databaseVersionCollection;
  final QuizAppDatabaseService db = QuizAppDatabaseService();

  /// 현재 개발단계에서는 Prod 서버, DB 구축이 안되있기 때문에 사용법 적어둡니다.
  /// MongoDB 에 직접적으로 collection 생성 해주셔야 합니다. (collection 이름 => version)
  /// query 데이터 생성 =>
  /// {
  ///   "version" : "updateVersion",
  ///   "androidVersion : "업데이트 버전 입력",
  ///   "iosVersion: "업데이트 버전 입력"
  /// }
  ///
  /// 강제 업데이트 os 별로 각 버전을 DB 에 수동으로 입력해주시면 됩니다.
  /// 앱 버전과 업데이트 버전을 비교해서 스토어로 던지게 됩니다.

  Future<DatabaseResp> getVersion() async {
    final Map<String, dynamic>? version = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .findOne({"version": "updateVersion"});
    if (version == null) {
      return DatabaseResp.error(error: DbRespError.failedLoadingAccount);
    } else {
      return DatabaseResp.success(data: Version.fromJson(version));
    }
  }

  Future<DatabaseResp> getVersionFirestore() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(_collection)
          .where("version", isEqualTo: "updateVersion")
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return DatabaseResp.success(
            data: Version.fromJson(querySnapshot.docs[0].data()! as Map<String, dynamic>));
      } else {
        return DatabaseResp.error(error: DbRespError.failedLoadingAccount);
      }
    } catch (e) {
      print(e);
      return DatabaseResp.error(error: DbRespError.failedLoadingAccount);
    }
  }
}
