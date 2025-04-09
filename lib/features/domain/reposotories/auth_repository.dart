import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/domain/usecases/auth_usecases/sign_in_with_email_usecase.dart';
import 'package:news_app/features/domain/usecases/auth_usecases/sign_up_with_email_usecase.dart';


abstract class AuthRepository{
  Future<Either<Failure, User?>> getCurrentUser();
  Future<Either<Failure, UserCredential>> signInWithEmailPassword(AuthParams params);
  Future<Either<Failure, UserCredential>> signUpWithEmailPassword(SignUpParams params);
  Future<Either<Failure, void>> signOut();
}