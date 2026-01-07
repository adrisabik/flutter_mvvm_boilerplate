import 'package:flutter_mvvm_boilerplate/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

/// Base repository interface for common CRUD operations.
///
/// Extend this interface for specific entity repositories.
/// All methods return `Either<Failure, T>` for consistent error handling.
abstract class BaseRepository<T, ID> {
  /// Get a single entity by ID
  Future<Either<Failure, T>> getById(ID id);

  /// Get all entities (with optional pagination)
  Future<Either<Failure, List<T>>> getAll({int? page, int? limit});

  /// Create a new entity
  Future<Either<Failure, T>> create(T entity);

  /// Update an existing entity
  Future<Either<Failure, T>> update(T entity);

  /// Delete an entity by ID
  Future<Either<Failure, void>> delete(ID id);
}
