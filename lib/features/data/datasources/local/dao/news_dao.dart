import 'package:floor/floor.dart';
import 'package:news_app/features/data/datasources/local/entity/article_local_entity.dart';

@dao
abstract class NewsDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNews(ArticleLocalEntity news);

  @Query('SELECT * FROM ArticleLocalEntity')
  Future<List<ArticleLocalEntity>?> getNews();

  @Query('DELETE FROM ArticleLocalEntity WHERE 1==1')
  Future<void> deleteAllNews();

  @Query('SELECT * FROM ArticleLocalEntity WHERE title LIKE :keyword')
  Future<List<ArticleLocalEntity>?> searchNews(String keyword);
}
