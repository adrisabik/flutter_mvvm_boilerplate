import 'package:flutter_mvvm_boilerplate/core/error/failures.dart';
import 'package:flutter_mvvm_boilerplate/domain/entities/user.dart';
import 'package:flutter_mvvm_boilerplate/domain/repositories/auth_repository.dart';
import 'package:flutter_mvvm_boilerplate/domain/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';

/// Parameters for login use case
class LoginParams {

  const LoginParams({required this.email, required this.password});
  final String email;
  final String password;
}

/// Use case for user login.
class LoginUseCase extends UseCase<User, LoginParams> {

  LoginUseCase(this._repository);
  final AuthRepository _repository;

  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    return _repository.login(email: params.email, password: params.password);
  }
}
