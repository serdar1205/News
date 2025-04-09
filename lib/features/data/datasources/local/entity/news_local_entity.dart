// import 'package:news_app/features/data/models/top_news_model.dart';
// import 'package:news_app/features/domain/entities/top_news_entity.dart';
// import 'package:floor/floor.dart';
//
// @entity
// class TopNewsLocalEntity {
//   @primaryKey
//   final int? id;
//   final String status;
//   final int totalResults;
//   final List<ArticleModel> articles;
//
//   TopNewsLocalEntity({
//     this.id,
//     required this.status,
//     required this.totalResults,
//     required this.articles,
//   });
//
//   TopNewsEntity toEntity() {
//     return TopNewsEntity(
//       status: status,
//       totalResults: totalResults,
//       articles: articles.map((e)=>e.toEntity()).toList(),
//     );
//   }
// }
