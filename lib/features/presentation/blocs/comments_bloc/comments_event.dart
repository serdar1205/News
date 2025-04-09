part of 'comments_bloc.dart';

sealed class CommentsEvent {}

class AddComment extends CommentsEvent{
  final CommentParams comment;

  AddComment(this.comment);
}
class GetComments extends CommentsEvent{
  final String articleId;

  GetComments(this.articleId);
}
