part of 'comments_count_bloc.dart';

sealed class CommentsCountState {}

final class CommentsCountInitial extends CommentsCountState {}

final class CommentsCountLoaded extends CommentsCountState {
  final Map<String, int> counts;

  CommentsCountLoaded(this.counts);
}

final class CommentsCountEmpty extends CommentsCountState {}

final class CommentsCountError extends CommentsCountState {}
