import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/domain/reposotories/comments_repository.dart';

class GetCommentsCountUseCase extends BaseUseCase<List<String>, Map<String, int> > {
  final CommentsRepository repository;

  GetCommentsCountUseCase({required this.repository});

  @override
  Future<Either<Failure, Map<String, int> >> execute(input) async {
    return await repository.getCommentsCount(input);
  }
}
