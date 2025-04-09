import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/domain/reposotories/auth_repository.dart';
import '../../../../core/error/failure.dart';


class SignUpWithEmailUseCase implements BaseUseCase<SignUpParams,UserCredential> {
  final AuthRepository repository;

  SignUpWithEmailUseCase(this.repository);

  @override
  Future<Either<Failure, UserCredential>> execute(SignUpParams params) async {
    return await repository.signUpWithEmailPassword(params);
  }
}


class SignUpParams {
  const SignUpParams({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });

  final String name;
  final String surname;
  final String email;
  final String password;

  Map<String, dynamic> toMap() => {
    'name': name,
    'surname': surname,
    'email': email,
    'password': password,
  };
}