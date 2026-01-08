import 'package:json_annotation/json_annotation.dart';

part 'api_response_model.g.dart';

/// Generic API response wrapper for consistent response handling.
@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  const ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.meta,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
  final bool success;
  final String? message;
  final T? data;
  final ApiMeta? meta;

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);
}

/// Pagination metadata for list responses.
@JsonSerializable()
class ApiMeta {
  const ApiMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory ApiMeta.fromJson(Map<String, dynamic> json) =>
      _$ApiMetaFromJson(json);
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  Map<String, dynamic> toJson() => _$ApiMetaToJson(this);
}
