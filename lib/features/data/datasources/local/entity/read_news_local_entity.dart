import 'package:news_app/features/data/models/top_news_model.dart';
import 'package:news_app/features/domain/entities/top_news_entity.dart';
import 'package:floor/floor.dart';

@entity
class ReadNewsLocalEntity {
  final SourceModel source;
  final String? author;
  @primaryKey
  final String title;
  final String? description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String? content;

  ReadNewsLocalEntity({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  ArticleEntity toEntity() {
    return ArticleEntity(
      source: source.toEntity(),
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
  }
}
