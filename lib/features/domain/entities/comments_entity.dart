import 'package:news_app/features/data/datasources/local/entity/comment_local_entity.dart';

class CommentsEntity {
  final String docId;
  final String articleId;
  final String comment;
  final String author;
  final String time;

  CommentsEntity({
    required this.docId,
    required this.articleId,
    required this.comment,
    required this.author,
    required this.time,
  });
}
