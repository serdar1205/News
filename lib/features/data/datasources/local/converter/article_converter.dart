import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:news_app/features/data/datasources/local/converter/date_time_converter.dart';
import 'package:news_app/features/data/models/top_news_model.dart';
import 'source_converter.dart';

class ArticleLocalEntityConverter
    extends TypeConverter<List<ArticleModel>, String> {
  @override
  List<ArticleModel> decode(String databaseValue) {
    final List<dynamic> decoded = jsonDecode(databaseValue);
    return decoded
        .map((item) => ArticleModel(
              source: SourceConverter().decode(item['source']),
              author: item['author'],
              title: item['title'],
              description: item['description'],
              url: item['url'],
              urlToImage: item['urlToImage'],
              publishedAt: DateTimeConverter().decode(item['publishedAt']),
              content: item['content'],
            ))
        .toList();
  }

  @override
  String encode(List<ArticleModel> value) {
    return jsonEncode(value
        .map((item) => {
              "source": SourceConverter().encode(item.source),
              "author": item.author,
              "title": item.title,
              "description": item.description,
              "url": item.url,
              "urlToImage": item.urlToImage,
              "publishedAt": item.publishedAt.toIso8601String(),
              "content": item.content,
            })
        .toList());
  }
}
