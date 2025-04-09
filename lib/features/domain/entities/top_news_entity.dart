import 'package:news_app/features/data/datasources/local/entity/read_news_local_entity.dart';
import 'package:news_app/features/data/models/top_news_model.dart';

class ArticleEntity {
  final SourceEntity source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String? content;

  ArticleEntity({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  ArticleEntity copyWith({
    SourceEntity? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
  }) =>
      ArticleEntity(
        source: source ?? this.source,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        urlToImage: urlToImage ?? this.urlToImage,
        publishedAt: publishedAt ?? this.publishedAt,
        content: content ?? this.content,
      );

  ReadNewsLocalEntity toCacheEntity() {
    return ReadNewsLocalEntity(
      source: source.toModel(),
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

class SourceEntity {
  final String? id;
  final String name;

  SourceEntity({
    required this.id,
    required this.name,
  });

  SourceEntity copyWith({
    String? id,
    String? name,
  }) =>
      SourceEntity(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  SourceModel toModel(){
    return SourceModel(id: id, name: name);
  }

}
