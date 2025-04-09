import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/domain/entities/comments_entity.dart';
import 'package:news_app/features/domain/reposotories/comments_repository.dart';

class GetCommentsUseCase extends StreamUseCase<String, List<CommentsEntity>> {
  final CommentsRepository repository;

  GetCommentsUseCase({required this.repository});

  @override
  Stream<Either<Failure, List<CommentsEntity>>> execute(params) {
    return repository.getComments(params);
  }
}
