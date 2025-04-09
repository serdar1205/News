// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDataBaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDataBaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDataBaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDataBase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDataBaseBuilderContract databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDataBaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder implements $AppDataBaseBuilderContract {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDataBaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDataBaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NewsDao? _newsDaoInstance;

  CommentsDao? _commentsDaoInstance;

  ReadNewsDao? _readNewsInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ArticleLocalEntity` (`source` TEXT NOT NULL, `author` TEXT, `title` TEXT NOT NULL, `description` TEXT, `url` TEXT NOT NULL, `urlToImage` TEXT NOT NULL, `publishedAt` INTEGER NOT NULL, `content` TEXT, PRIMARY KEY (`title`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CommentLocalEntity` (`docId` TEXT NOT NULL, `articleId` TEXT NOT NULL, `comment` TEXT NOT NULL, `author` TEXT NOT NULL, `time` TEXT NOT NULL, PRIMARY KEY (`docId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ReadNewsLocalEntity` (`source` TEXT NOT NULL, `author` TEXT, `title` TEXT NOT NULL, `description` TEXT, `url` TEXT NOT NULL, `urlToImage` TEXT NOT NULL, `publishedAt` INTEGER NOT NULL, `content` TEXT, PRIMARY KEY (`title`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NewsDao get newsDao {
    return _newsDaoInstance ??= _$NewsDao(database, changeListener);
  }

  @override
  CommentsDao get commentsDao {
    return _commentsDaoInstance ??= _$CommentsDao(database, changeListener);
  }

  @override
  ReadNewsDao get readNews {
    return _readNewsInstance ??= _$ReadNewsDao(database, changeListener);
  }
}

class _$NewsDao extends NewsDao {
  _$NewsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _articleLocalEntityInsertionAdapter = InsertionAdapter(
            database,
            'ArticleLocalEntity',
            (ArticleLocalEntity item) => <String, Object?>{
                  'source': _sourceConverter.encode(item.source),
                  'author': item.author,
                  'title': item.title,
                  'description': item.description,
                  'url': item.url,
                  'urlToImage': item.urlToImage,
                  'publishedAt': _dateTimeConverter.encode(item.publishedAt),
                  'content': item.content
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ArticleLocalEntity>
      _articleLocalEntityInsertionAdapter;

  @override
  Future<List<ArticleLocalEntity>?> getNews() async {
    return _queryAdapter.queryList('SELECT * FROM ArticleLocalEntity',
        mapper: (Map<String, Object?> row) => ArticleLocalEntity(
            source: _sourceConverter.decode(row['source'] as String),
            author: row['author'] as String?,
            title: row['title'] as String,
            description: row['description'] as String?,
            url: row['url'] as String,
            urlToImage: row['urlToImage'] as String,
            publishedAt: _dateTimeConverter.decode(row['publishedAt'] as int),
            content: row['content'] as String?));
  }

  @override
  Future<void> deleteAllNews() async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM ArticleLocalEntity WHERE 1==1');
  }

  @override
  Future<List<ArticleLocalEntity>?> searchNews(String keyword) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ArticleLocalEntity WHERE title LIKE ?1',
        mapper: (Map<String, Object?> row) => ArticleLocalEntity(
            source: _sourceConverter.decode(row['source'] as String),
            author: row['author'] as String?,
            title: row['title'] as String,
            description: row['description'] as String?,
            url: row['url'] as String,
            urlToImage: row['urlToImage'] as String,
            publishedAt: _dateTimeConverter.decode(row['publishedAt'] as int),
            content: row['content'] as String?),
        arguments: [keyword]);
  }

  @override
  Future<void> insertNews(ArticleLocalEntity news) async {
    await _articleLocalEntityInsertionAdapter.insert(
        news, OnConflictStrategy.replace);
  }
}

class _$CommentsDao extends CommentsDao {
  _$CommentsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _commentLocalEntityInsertionAdapter = InsertionAdapter(
            database,
            'CommentLocalEntity',
            (CommentLocalEntity item) => <String, Object?>{
                  'docId': item.docId,
                  'articleId': item.articleId,
                  'comment': item.comment,
                  'author': item.author,
                  'time': item.time
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CommentLocalEntity>
      _commentLocalEntityInsertionAdapter;

  @override
  Future<List<CommentLocalEntity>?> getComments(String articleId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM CommentLocalEntity WHERE articleId=?1',
        mapper: (Map<String, Object?> row) => CommentLocalEntity(
            docId: row['docId'] as String,
            articleId: row['articleId'] as String,
            comment: row['comment'] as String,
            author: row['author'] as String,
            time: row['time'] as String),
        arguments: [articleId]);
  }

  @override
  Future<void> deleteAllComments() async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM CommentLocalEntity WHERE 1==1');
  }

  @override
  Future<void> insertComment(CommentLocalEntity comment) async {
    await _commentLocalEntityInsertionAdapter.insert(
        comment, OnConflictStrategy.replace);
  }
}

class _$ReadNewsDao extends ReadNewsDao {
  _$ReadNewsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _readNewsLocalEntityInsertionAdapter = InsertionAdapter(
            database,
            'ReadNewsLocalEntity',
            (ReadNewsLocalEntity item) => <String, Object?>{
                  'source': _sourceConverter.encode(item.source),
                  'author': item.author,
                  'title': item.title,
                  'description': item.description,
                  'url': item.url,
                  'urlToImage': item.urlToImage,
                  'publishedAt': _dateTimeConverter.encode(item.publishedAt),
                  'content': item.content
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ReadNewsLocalEntity>
      _readNewsLocalEntityInsertionAdapter;

  @override
  Future<List<ReadNewsLocalEntity>?> getReadNews() async {
    return _queryAdapter.queryList('SELECT * FROM ReadNewsLocalEntity',
        mapper: (Map<String, Object?> row) => ReadNewsLocalEntity(
            source: _sourceConverter.decode(row['source'] as String),
            author: row['author'] as String?,
            title: row['title'] as String,
            description: row['description'] as String?,
            url: row['url'] as String,
            urlToImage: row['urlToImage'] as String,
            publishedAt: _dateTimeConverter.decode(row['publishedAt'] as int),
            content: row['content'] as String?));
  }

  @override
  Future<void> deleteReadNews() async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM ReadNewsLocalEntity WHERE 1==1');
  }

  @override
  Future<void> insertReadingNews(ReadNewsLocalEntity news) async {
    await _readNewsLocalEntityInsertionAdapter.insert(
        news, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _sourceConverter = SourceConverter();
final _dateTimeConverter = DateTimeConverter();
final _articleLocalEntityConverter = ArticleLocalEntityConverter();
