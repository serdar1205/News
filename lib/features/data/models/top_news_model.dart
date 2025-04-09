import 'package:news_app/features/data/datasources/local/entity/article_local_entity.dart';
import 'package:news_app/features/data/datasources/local/entity/source_local_entity.dart';
import 'package:news_app/features/domain/entities/top_news_entity.dart';

class ArticleModel {
  final SourceModel source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String? content;

  ArticleModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleModel.fromMap(Map<String, dynamic> json) => ArticleModel(
        source: SourceModel.fromMap(json["source"]),
        author: json["author"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        url: json["url"] ?? '',
        urlToImage: json["urlToImage"] ?? '',
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "source": source.toMap(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };

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

  ArticleLocalEntity toCacheEntity() {
    return ArticleLocalEntity(
      source: source,
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

class SourceModel {
  final String? id;
  final String name;

  SourceModel({
    required this.id,
    required this.name,
  });

  SourceModel copyWith({
    String? id,
    String? name,
  }) =>
      SourceModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory SourceModel.fromMap(Map<String, dynamic> json) => SourceModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };

  SourceEntity toEntity() {
    return SourceEntity(id: id, name: name);
  }

  SourceLocalEntity toCacheEntity() {
    return SourceLocalEntity(id: id, name: name);
  }
}
