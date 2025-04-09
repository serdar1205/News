import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/domain/entities/comments_entity.dart';
import 'package:news_app/features/domain/reposotories/comments_repository.dart';

class AddCommentUseCase
    extends BaseUseCase<CommentParams, List<CommentsEntity>> {
  final CommentsRepository repository;

  AddCommentUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CommentsEntity>>> execute(input) async {
    return await repository.addComment(input);
  }
}

class CommentParams {
  final String articleId;
  final String comment;

  CommentParams({required this.articleId, required this.comment});
}
