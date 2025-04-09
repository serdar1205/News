part of 'comments_count_bloc.dart';

sealed class CommentsCountEvent {}

class GetCommentsCount extends CommentsCountEvent{
  final List<String> articleIds;

  GetCommentsCount(this.articleIds);
}