part of 'news_bloc.dart';

sealed class NewsEvent {}

class GetTopNews extends NewsEvent {
  final int page;
  GetTopNews({this.page = 1});
}
class SearchNews extends NewsEvent {
  final String keyword;

  SearchNews(this.keyword);
}
