import 'package:flutter_mvvm_boilerplate/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

/// Base class for all use cases.
///
/// Use cases encapsulate a single piece of business logic.
/// They receive parameters and return `Either<Failure, T>`.
///
/// Example:
/// ```dart
/// class GetUserUseCase extends UseCase<User, GetUserParams> {
///   final UserRepository repository;
///
///   GetUserUseCase(this.repository);
///
///   @override
///   Future<Either<Failure, User>> call(GetUserParams params) {
///     return repository.getUserById(params.userId);
///   }
/// }
/// ```
// ignore: one_member_abstracts
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Use this class when the use case doesn't need any parameters.
class NoParams {
  const NoParams();
}

/// Base class for paginated use cases.
///
/// Use cases that fetch lists of items with pagination should extend this.
///
/// Example:
/// ```dart
/// class GetProductsUseCase extends PaginatedUseCase<Product, GetProductsParams> {
///   final ProductRepository repository;
///
///   GetProductsUseCase(this.repository);
///
///   @override
///   Future<Either<Failure, PaginatedResult<Product>>> call(
///     GetProductsParams params,
///     PaginationParams pagination,
///   ) {
///     return repository.getProducts(
///       category: params.category,
///       page: pagination.page,
///       perPage: pagination.perPage,
///     );
///   }
/// }
/// ```
// ignore: one_member_abstracts
abstract class PaginatedUseCase<T, Params> {
  Future<Either<Failure, PaginatedResult<T>>> call(
    Params params,
    PaginationParams pagination,
  );
}

/// Parameters for pagination.
class PaginationParams {
  const PaginationParams({this.page = 1, this.perPage = 20});

  /// Current page number (1-indexed).
  final int page;

  /// Number of items per page.
  final int perPage;

  /// Gets the offset for SQL-style pagination.
  int get offset => (page - 1) * perPage;

  /// Creates next page params.
  PaginationParams nextPage() =>
      PaginationParams(page: page + 1, perPage: perPage);

  /// Creates first page params.
  PaginationParams firstPage() => PaginationParams(perPage: perPage);
}

/// Result of a paginated query.
class PaginatedResult<T> {
  const PaginatedResult({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    this.perPage = 20,
  });

  /// Empty result for initial state.
  factory PaginatedResult.empty() => const PaginatedResult(
    items: [],
    currentPage: 0,
    totalPages: 0,
    totalItems: 0,
  );

  /// Factory from common API response format.
  factory PaginatedResult.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final data = json['data'] as List;
    final meta = json['meta'] as Map<String, dynamic>?;
    final pagination = json['pagination'] as Map<String, dynamic>?;

    // Support both 'meta' and 'pagination' key styles
    final paginationData = meta ?? pagination ?? json;

    return PaginatedResult(
      items: data.map((e) => fromJson(e as Map<String, dynamic>)).toList(),
      currentPage:
          paginationData['current_page'] as int? ??
          paginationData['page'] as int? ??
          1,
      totalPages:
          paginationData['last_page'] as int? ??
          paginationData['total_pages'] as int? ??
          1,
      totalItems:
          paginationData['total'] as int? ??
          paginationData['total_items'] as int? ??
          data.length,
      perPage: paginationData['per_page'] as int? ?? 20,
    );
  }

  /// The items for the current page.
  final List<T> items;

  /// Current page number (1-indexed).
  final int currentPage;

  /// Total number of pages.
  final int totalPages;

  /// Total number of items across all pages.
  final int totalItems;

  /// Number of items per page.
  final int perPage;

  /// Whether there are more pages after this one.
  bool get hasNextPage => currentPage < totalPages;

  /// Whether there are pages before this one.
  bool get hasPreviousPage => currentPage > 1;

  /// Whether the result is empty.
  bool get isEmpty => items.isEmpty;

  /// Whether the result has items.
  bool get isNotEmpty => items.isNotEmpty;

  /// Creates a copy with additional items appended.
  PaginatedResult<T> appendItems(PaginatedResult<T> other) {
    return PaginatedResult(
      items: [...items, ...other.items],
      currentPage: other.currentPage,
      totalPages: other.totalPages,
      totalItems: other.totalItems,
      perPage: other.perPage,
    );
  }

  @override
  String toString() =>
      'PaginatedResult(page: $currentPage/$totalPages, items: ${items.length}, total: $totalItems)';
}
