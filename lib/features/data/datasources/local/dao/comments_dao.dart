import 'package:floor/floor.dart';
import 'package:news_app/features/data/datasources/local/entity/comment_local_entity.dart';

@dao
abstract class CommentsDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertComment(CommentLocalEntity comment);

  @Query('SELECT * FROM CommentLocalEntity WHERE articleId=:articleId')
  Future<List<CommentLocalEntity>?> getComments(String articleId);

  @Query('DELETE FROM CommentLocalEntity WHERE 1==1')
  Future<void> deleteAllComments();
}
