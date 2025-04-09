import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/domain/entities/comments_entity.dart';
import 'package:news_app/features/domain/usecases/comments/add_comment_usecase.dart';

abstract class CommentsRepository {
  Stream<Either<Failure, List<CommentsEntity>>> getComments(String articleId);

  Future<Either<Failure, List<CommentsEntity>>> addComment(CommentParams comment);

  Future<Either<Failure, Map<String, int>>>  getCommentsCount(List<String>  articleId) ;
}
