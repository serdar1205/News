import 'dart:async';
import 'package:floor/floor.dart';
import 'package:news_app/features/data/datasources/local/converter/article_converter.dart';
import 'package:news_app/features/data/datasources/local/converter/date_time_converter.dart';
import 'package:news_app/features/data/datasources/local/converter/source_converter.dart';
import 'package:news_app/features/data/datasources/local/dao/comments_dao.dart';
import 'package:news_app/features/data/datasources/local/dao/news_dao.dart';
import 'package:news_app/features/data/datasources/local/dao/read_news_dao.dart';
import 'package:news_app/features/data/datasources/local/entity/article_local_entity.dart';
import 'package:news_app/features/data/datasources/local/entity/comment_local_entity.dart';
import 'package:news_app/features/data/datasources/local/entity/read_news_local_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@TypeConverters([
  SourceConverter,
  DateTimeConverter,
  ArticleLocalEntityConverter,
])

@Database(version: 1, entities: [
  ArticleLocalEntity,
  CommentLocalEntity,
  ReadNewsLocalEntity,
])

abstract class AppDataBase extends FloorDatabase {
  NewsDao get newsDao;
  CommentsDao get commentsDao;
  ReadNewsDao get readNews;
}
