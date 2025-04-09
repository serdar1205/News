import 'package:floor/floor.dart';
import 'package:news_app/features/data/datasources/local/entity/read_news_local_entity.dart';

@dao
abstract class ReadNewsDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertReadingNews(ReadNewsLocalEntity news);

  @Query('SELECT * FROM ReadNewsLocalEntity')
  Future<List<ReadNewsLocalEntity>?> getReadNews();

  @Query('DELETE FROM ReadNewsLocalEntity WHERE 1==1')
  Future<void> deleteReadNews();
}
