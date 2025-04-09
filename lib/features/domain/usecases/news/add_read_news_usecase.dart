import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/domain/entities/top_news_entity.dart';
import 'package:news_app/features/domain/reposotories/news_repository.dart';

class AddReadNewsUseCase extends BaseUseCase<ArticleEntity, bool> {
  final NewsRepository repository;

  AddReadNewsUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> execute(input) async {
    return await repository.addReadNews(input);
  }
}