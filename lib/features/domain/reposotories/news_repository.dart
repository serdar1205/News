
import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/domain/entities/top_news_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<ArticleEntity>>> getTopNews(int page);
  Future<Either<Failure, List<ArticleEntity>>> searchNews(String keyword);
  Future<Either<Failure, bool>> addReadNews(ArticleEntity readData);
  Future<Either<Failure, List<ArticleEntity>>> getReadNews();
  Future<Either<Failure, bool>> deleteReadNews();

}