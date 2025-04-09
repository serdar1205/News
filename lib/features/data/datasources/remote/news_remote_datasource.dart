import 'package:news_app/core/constants/strings/app_strings.dart';
import 'package:news_app/core/constants/strings/endpoints.dart';
import 'package:news_app/core/network/api_provider.dart';
import 'package:news_app/features/data/models/top_news_model.dart';

abstract class NewsRemoteDatasource {
  Future<List<ArticleModel>> getTopNews(int page);

  Future<List<ArticleModel>> searchNews(String keyword);
}

class NewsRemoteDatasourceImpl implements NewsRemoteDatasource {
  final ApiProvider apiProvider;

  NewsRemoteDatasourceImpl({required this.apiProvider});

  @override
  Future<List<ArticleModel>> getTopNews(int page) async {
    final response = await apiProvider.get(
      endPoint: ApiEndpoints.topHeadlines,
      query: {
        'country': ApiEndpoints.countryCode,
        'apiKey': ApiEndpoints.apikey,
        'page': page,
        'pageSize': AppStrings.defaultPageSize,
      },
    );

    final responseBody = response.data['articles'] as List;

    final result = responseBody.map((e) => ArticleModel.fromMap(e)).toList();

    return result;
  }

  @override
  Future<List<ArticleModel>> searchNews(String keyword) async {
    final response = await apiProvider.get(
      endPoint: ApiEndpoints.topHeadlines,
      query: {
        'q': keyword,
        'apiKey': ApiEndpoints.apikey,
      },
    );

    final responseBody = response.data['articles'] as List;

    final result = responseBody.map((e) => ArticleModel.fromMap(e)).toList();

    return result;
  }
}
