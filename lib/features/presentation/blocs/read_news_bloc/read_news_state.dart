part of 'read_news_bloc.dart';

sealed class ReadNewsState {}

final class ReadNewsLoading extends ReadNewsState {}
final class ReadNewsLoaded extends ReadNewsState {
  final List<ArticleEntity> data;

  ReadNewsLoaded(this.data);
}
final class ReadNewsError extends ReadNewsState {}
final class ReadNewsEmpty extends ReadNewsState {}
