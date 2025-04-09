part of 'read_news_bloc.dart';

sealed class ReadNewsEvent {}

class GetReadNews extends ReadNewsEvent{}
class DeleteReadNews extends ReadNewsEvent{}
class AddReadNews extends ReadNewsEvent{
  final ArticleEntity newsEntity;

  AddReadNews(this.newsEntity);
}
