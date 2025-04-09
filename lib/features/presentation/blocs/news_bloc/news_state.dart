part of 'news_bloc.dart';

sealed class NewsState {}

final class NewsLoading extends NewsState {}
final class NewsLoaded extends NewsState {
  final List<ArticleEntity> data;

  NewsLoaded(this.data);
}
final class NewsError extends NewsState {}
final class NewsConnectionError extends NewsState {}
