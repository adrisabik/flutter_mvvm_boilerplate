import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_result.freezed.dart';

/// Generic pagination wrapper for list responses.
@freezed
class PaginatedResult<T> with _$PaginatedResult<T> {
  const factory PaginatedResult({
    required List<T> items,
    required bool hasMore,
    required int currentPage,
    int? totalItems,
    int? totalPages,
  }) = _PaginatedResult<T>;
}
