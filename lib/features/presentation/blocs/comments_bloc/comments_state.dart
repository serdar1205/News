part of 'comments_bloc.dart';

sealed class CommentsState {}

final class CommentsLoading extends CommentsState {}
final class CommentsLoaded extends CommentsState {
  final List<CommentsEntity> data;

  CommentsLoaded(this.data);
}
final class CommentsError extends CommentsState {}
final class CommentsEmpty extends CommentsState {}
