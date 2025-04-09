import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/constants/strings/app_strings.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/datasources/remote/auth_remote_datasource.dart';
import 'package:news_app/features/domain/reposotories/auth_repository.dart';
import 'package:news_app/features/domain/usecases/auth_usecases/sign_in_with_email_usecase.dart';
import 'package:news_app/features/domain/usecases/auth_usecases/sign_up_with_email_usecase.dart';
import '../../../core/network/network.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getCurrentUser();
        return Right(response);
      } on FirebaseAuthException catch (e) {
        return Left(ServerFailure(e.code));
      }
    } else {
      return const Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithEmailPassword(
      AuthParams params) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.signIn(params);
        return Right(response);
      } on FirebaseAuthException catch (e) {
        return Left(ServerFailure(e.code));
      }
    } else {
      return const Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.signOut();
        return Right(response);
      } on FirebaseAuthException catch (e) {
        return Left(ServerFailure(e.code));
      }
    } else {
      return const Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signUpWithEmailPassword(
      SignUpParams params) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.signUp(params);
        return Right(response);
      } on FirebaseAuthException catch (e) {
        return Left(ServerFailure(e.code));
      }
    } else {
      return const Left(ConnectionFailure(AppStrings.noInternet));
    }
  }
}
