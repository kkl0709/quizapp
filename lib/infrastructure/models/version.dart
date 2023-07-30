import 'package:freezed_annotation/freezed_annotation.dart';

part 'version.freezed.dart';
part 'version.g.dart';

@freezed
class Version with _$Version {
  const Version._();
  const factory Version({
    String? version,
    String? androidVersion,
    String? iosVersion,
  }) = _Version;

  factory Version.fromJson(Map<String, Object?> json) =>
      _$VersionFromJson(json);
}
