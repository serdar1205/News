import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/domain/reposotories/auth_repository.dart';
import '../../../../core/error/failure.dart';

class GetCurrentUserUseCase implements BaseUseCase<NoParams,User?> {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, User?>> execute(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
