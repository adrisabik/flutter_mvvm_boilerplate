import 'package:flutter_mvvm_boilerplate/core/error/failures.dart';
import 'package:flutter_mvvm_boilerplate/domain/repositories/auth_repository.dart';
import 'package:flutter_mvvm_boilerplate/domain/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Use case for user logout.
@injectable
class LogoutUseCase extends UseCase<void, NoParams> {
  LogoutUseCase(this._repository);
  final AuthRepository _repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return _repository.logout();
  }
}
