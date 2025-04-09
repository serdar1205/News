import 'package:dartz/dartz.dart';
import 'package:news_app/core/constants/strings/app_strings.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/network/network.dart';
import 'package:news_app/features/data/datasources/db/app_database.dart';
import 'package:news_app/features/data/datasources/remote/news_remote_datasource.dart';
import 'package:news_app/features/domain/entities/top_news_entity.dart';
import 'package:news_app/features/domain/reposotories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDatasource remoteDataSource;
  final NetworkInfo networkInfo;
  final AppDataBase localDataSource;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ArticleEntity>>> getTopNews(int page) async {
    final bool isConnected = await networkInfo.isConnected;
    final dao = localDataSource.newsDao;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getTopNews(page);

        final result = response.map((e) => e.toEntity()).toList();

        //final localNews = await dao.getNews();

        // if (localNews != null) {
        //   await dao.deleteAllNews();
        // }

        for (var item in response) {
          await dao.insertNews(item.toCacheEntity());
        }

        return Right(result);
      } catch (error) {
        return await _getLocalNews(isConnected);
      }
    } else {
      return await _getLocalNews(isConnected);
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> searchNews(
      String keyword) async {
    final bool isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final response = await remoteDataSource.searchNews(keyword);

        final result = response.map((e) => e.toEntity()).toList();

        return Right(result);
      } catch (error) {
        return Left(ServerFailure('$error'));
      }
    } else {
      final localData = await _searchFromLocalData(keyword);
      return Right(localData);
    }
  }

  Future<List<ArticleEntity>> _searchFromLocalData(String keyword) async {
    final dao = localDataSource.newsDao;
    final localData = await dao.searchNews('%$keyword%');

    if (localData != null && localData.isNotEmpty) {
      final localNewsEntity = localData.map((e) => e.toEntity()).toList();
      return localNewsEntity;
    } else {
      return [];
    }
  }

  Future<Either<Failure, List<ArticleEntity>>> _getLocalNews(
      bool isConnected) async {
    final dao = localDataSource.newsDao;
    final localNews = await dao.getNews();

    if (localNews != null && localNews.isNotEmpty) {
      final localNewsEntity = localNews.map((e) => e.toEntity()).toList();
      return Right(localNewsEntity);
    } else {
      if (isConnected) {
        return Left(ServerFailure(''));
      } else {
        return Left(ConnectionFailure(AppStrings.noInternet));
      }
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getReadNews() async {
    final dao = localDataSource.readNews;
    try {
      final readNews = await dao.getReadNews();

      if (readNews != null && readNews.isNotEmpty) {
        final result = readNews.map((e) => e.toEntity()).toList();

        return Right(result);
      } else {
        return Right([]);
      }
    } catch (error) {
      return Left(EmptyCacheFailure('Empty db $error'));
    }
  }

  @override
  Future<Either<Failure, bool>> addReadNews(ArticleEntity readData) async {
    final dao = localDataSource.readNews;
    try {
      await dao.insertReadingNews(readData.toCacheEntity());
      return Right(true);
    } catch (error) {
      return Left(EmptyCacheFailure('Empty db $error'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteReadNews() async {
    final dao = localDataSource.readNews;
    try {
      await dao.deleteReadNews();
      final readNews = await dao.getReadNews();
      if (readNews == null || readNews.isEmpty) {
        return Right(true);
      } else {
        return Right(false);
      }
    } catch (error) {
      return Left(EmptyCacheFailure('Empty db $error'));
    }
  }
}
