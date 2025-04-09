import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/domain/entities/top_news_entity.dart';
import 'package:news_app/features/domain/reposotories/news_repository.dart';

class GetReadNewsUseCase extends BaseUseCase<NoParams, List<ArticleEntity>> {
  final NewsRepository repository;

  GetReadNewsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ArticleEntity>>> execute(input) async {
    return await repository.getReadNews();
  }
}