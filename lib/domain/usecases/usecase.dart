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
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Use this class when the use case doesn't need any parameters.
class NoParams {
  const NoParams();
}
