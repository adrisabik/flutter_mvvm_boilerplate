import 'package:flutter_mvvm_boilerplate/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Data Transfer Object for User.
///
/// This model is used in the data layer to parse API responses.
/// Use [toEntity] to convert to domain layer [User].
///
/// Example:
/// ```dart
/// final userModel = UserModel.fromJson(response.data);
/// final user = userModel.toEntity();
/// ```
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    String? name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'email_verified') @Default(false) bool emailVerified,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    // Additional fields from API that aren't in domain entity
    String? phone,
    String? role,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Converts this DTO to domain entity.
  User toEntity() => User(
    id: id,
    email: email,
    name: name,
    avatarUrl: avatarUrl,
    isEmailVerified: emailVerified,
    createdAt: createdAt,
  );

  /// Creates a DTO from domain entity.
  static UserModel fromEntity(User user) => UserModel(
    id: user.id,
    email: user.email,
    name: user.name,
    avatarUrl: user.avatarUrl,
    emailVerified: user.isEmailVerified,
    createdAt: user.createdAt,
  );
}
