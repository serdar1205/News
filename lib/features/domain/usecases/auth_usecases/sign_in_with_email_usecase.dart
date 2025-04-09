import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/domain/reposotories/auth_repository.dart';
import '../../../../core/error/failure.dart';

class SignInWithEmailUseCase implements BaseUseCase<AuthParams ,UserCredential> {
  final AuthRepository repository;

  SignInWithEmailUseCase(this.repository);

  @override
  Future<Either<Failure, UserCredential>> execute(AuthParams params) async {
    return await repository.signInWithEmailPassword(params);
  }
}

class AuthParams {
  final String email;
  final String password;

  AuthParams({required this.email, required this.password});
}
