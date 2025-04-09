import 'package:dartz/dartz.dart';
import 'package:news_app/core/constants/strings/app_strings.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/network/network.dart';
import 'package:news_app/features/data/datasources/db/app_database.dart';
import 'package:news_app/features/data/datasources/remote/comments_remote_datasource.dart';
import 'package:news_app/features/domain/entities/comments_entity.dart';
import 'package:news_app/features/domain/reposotories/comments_repository.dart';
import 'package:news_app/features/domain/usecases/comments/add_comment_usecase.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  final NetworkInfo networkInfo;
  final AppDataBase localDataSource;
  final CommentsRemoteDatasource remoteDatasource;

  CommentsRepositoryImpl(
    this.localDataSource,
    this.remoteDatasource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, List<CommentsEntity>>> addComment(
      CommentParams params) async {
    final bool isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return const Left(ConnectionFailure(AppStrings.noInternet));
    }

    try {
      final newComment = await remoteDatasource.addComment(params);

      if (newComment == null) {
        return Left(ServerFailure('Failed to add comment to firestore'));
      }

      final dao = localDataSource.commentsDao;
      await dao.insertComment(newComment.toCacheEntity());
      final localComments = await dao.getComments(params.articleId);

      if (localComments == null || localComments.isEmpty) {
        return Left(EmptyCacheFailure('EmptyCacheFailure'));
      }

      final localNewsEntity = localComments.map((e) => e.toEntity()).toList();
      return Right(localNewsEntity);
    } catch (e) {
      return Left(EmptyCacheFailure('EmptyCacheFailure'));
    }
  }

  @override
  Stream<Either<Failure, List<CommentsEntity>>> getComments(
      String articleId) async* {
    final bool isConnected = await networkInfo.isConnected;
    final dao = localDataSource.commentsDao;

    if (isConnected) {
      try {
        final remoteCommentsStream = remoteDatasource.getComments(articleId);

        await for (var messages in remoteCommentsStream) {
          for (var item in messages) {
            await dao.insertComment(item.toCacheEntity());
          }

          final commentsEntities =
              messages.map((comment) => comment.toEntity()).toList();
          yield Right(commentsEntities);
        }
      } catch (e) {
        yield* _getLocalComments(articleId, isConnected);
      }
    } else {
      yield* _getLocalComments(articleId, isConnected);
    }
  }

  Stream<Either<Failure, List<CommentsEntity>>> _getLocalComments(
      String articleId, bool isConnected) async* {
    final dao = localDataSource.commentsDao;
    try {
      final localComments = await dao.getComments(articleId);

      if (localComments != null && localComments.isNotEmpty) {
        final localCommentsEntities =
            localComments.map((e) => e.toEntity()).toList();
        yield Right(localCommentsEntities);
      } else {
        yield* _handleEmptyComments(isConnected);
      }
    } catch (e) {
      yield* _handleError(e, isConnected);
    }
  }

  @override
  Future<Either<Failure, Map<String, int>>> getCommentsCount(
      List<String> articleId) async {
    final bool isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final remoteCommentsCount =
            await remoteDatasource.getCommentsCountForArticles(articleId);
        return Right(remoteCommentsCount);
      } catch (e) {
        return _getLocalCommentsCount(articleId);
      }
    } else {
      return _getLocalCommentsCount(articleId);
    }
  }

  Future<Either<Failure, Map<String, int>>> _getLocalCommentsCount(
      List<String> articleIds) async {
    final dao = localDataSource.commentsDao;
    try {
      Map<String, int> results = {};

      for (final id in articleIds) {
        final localComments = await dao.getComments(id);

        if (localComments != null && localComments.isNotEmpty) {
          results[id] = localComments.length;
        }
      }

      return Right(results);
    } catch (e) {
      return Left(EmptyCacheFailure('$e'));
    }
  }

  Stream<Either<Failure, List<CommentsEntity>>> _handleEmptyComments(
      bool isConnected) async* {
    if (isConnected) {
      yield Left(EmptyCacheFailure('No local comments found.'));
    } else {
      yield Left(ServerFailure('No local comments found on the server.'));
    }
  }

  Stream<Either<Failure, List<CommentsEntity>>> _handleError(
      Object error, bool isConnected) async* {
    if (isConnected) {
      yield Left(EmptyCacheFailure('Error fetching local comments: $error.'));
    } else {
      yield Left(ServerFailure('Error fetching local comments.'));
    }
  }
}
