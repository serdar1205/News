import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/domain/reposotories/news_repository.dart';

class DeleteReadNewsUseCase extends BaseUseCase<NoParams, bool> {
  final NewsRepository repository;

  DeleteReadNewsUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> execute(input) async {
    return await repository.deleteReadNews();
  }
}