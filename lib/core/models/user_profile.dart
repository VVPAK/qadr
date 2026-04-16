import 'package:freezed_annotation/freezed_annotation.dart';

import '../constants/islamic_constants.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    String? name,
    @Default(Madhab.hanafi) Madhab madhab,
    @Default('en') String language,
    double? latitude,
    double? longitude,
    @Default(true) bool notificationsEnabled,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
