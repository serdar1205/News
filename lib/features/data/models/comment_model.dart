import 'package:news_app/features/data/datasources/local/entity/comment_local_entity.dart';
import 'package:news_app/features/domain/entities/comments_entity.dart';

class CommentModel {
  final String docId;
  final String articleId;
  final String comment;
  final String author;
  final String time;

  CommentModel({
    required this.docId,
    required this.articleId,
    required this.comment,
    required this.author,
    required this.time,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      docId: map['docId'] ?? '',
      articleId: map['articleId'] ?? '',
      comment: map['comment'] ?? '',
      author: map['author'] ?? '',
      time: map['time'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'docId': docId,
        'articleId': articleId,
        'comment': comment,
        'author': author,
        'time': time,
      };

  CommentsEntity toEntity() {
    return CommentsEntity(
      docId: docId,
      articleId: articleId,
      comment: comment,
      author: author,
      time: time,
    );
  }
  CommentLocalEntity toCacheEntity() {
    return CommentLocalEntity(
      docId: docId,
      articleId: articleId,
      comment: comment,
      author: author,
      time: time,
    );
  }
}
