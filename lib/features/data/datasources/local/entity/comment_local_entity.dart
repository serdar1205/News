import 'package:floor/floor.dart';
import 'package:news_app/features/domain/entities/comments_entity.dart';

@entity
class CommentLocalEntity {
  @primaryKey
  final String docId;
  final String articleId;
  final String comment;
  final String author;
  final String time;

  CommentLocalEntity({
    required this.docId,
    required this.articleId,
    required this.comment,
    required this.author,
    required this.time,
  });

  CommentsEntity toEntity() {
    return CommentsEntity(
      docId: docId,
      articleId: articleId,
      comment: comment,
      author: author,
      time: time,
    );
  }
}
