import 'package:dartz/dartz.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/domain/reposotories/auth_repository.dart';
import '../../../../core/error/failure.dart';

class SignOutUseCase implements BaseUseCase<NoParams,void> {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(NoParams params) async {
    return await repository.signOut();
  }
}

