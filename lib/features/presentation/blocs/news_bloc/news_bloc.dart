import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/domain/entities/top_news_entity.dart';
import 'package:news_app/features/domain/usecases/news/get_top_news_usecase.dart';
import 'package:news_app/features/domain/usecases/news/search_news_usecase.dart';
import 'package:news_app/features/presentation/blocs/comments_count_bloc/comments_count_bloc.dart';
import 'package:news_app/locator.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetTopNewsUseCase _getTopNewsUseCase =
      GetTopNewsUseCase(repository: locator());

  final SearchNewsUseCase _searchNewsUseCase =
      SearchNewsUseCase(repository: locator());

  NewsBloc() : super(NewsLoading()) {
    on<GetTopNews>(_onGetTopNews);
    on<SearchNews>(_onSearchNews);
  }

  List<ArticleEntity> _allTopNews = [];
  bool canLoad = true;

  Future<void> _onGetTopNews(GetTopNews event, Emitter<NewsState> emit) async {
    final result = await _getTopNewsUseCase.execute(event.page);

    result.fold((failure) {
      if (failure is ConnectionFailure) {
        emit(NewsConnectionError());
      } else {
        emit(NewsError());
      }
    }, (fetchedNews) {
      canLoad = fetchedNews.isNotEmpty;

      if (event.page == 1) {
        _allTopNews = fetchedNews;
      } else {
        _allTopNews.addAll(fetchedNews);
      }

      final articleIds = _allTopNews.map((article) => article.title).toList();

      locator<CommentsCountBloc>().add(GetCommentsCount(articleIds));

      emit(NewsLoaded(_allTopNews));
    });
  }

  Future<void> _onSearchNews(SearchNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await _searchNewsUseCase.execute(event.keyword);

    result.fold((failure) {
      if (failure is ConnectionFailure) {
        emit(NewsConnectionError());
      } else {
        emit(NewsError());
      }
    }, (success) {
      emit(NewsLoaded(success));
    });
  }
}
