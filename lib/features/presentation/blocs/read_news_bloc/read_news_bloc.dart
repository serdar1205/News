import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/domain/entities/top_news_entity.dart';
import 'package:news_app/features/domain/usecases/news/add_read_news_usecase.dart';
import 'package:news_app/features/domain/usecases/news/delete_read_news_usecase.dart';
import 'package:news_app/features/domain/usecases/news/get_read_news_usecase.dart';
import 'package:news_app/locator.dart';

part 'read_news_event.dart';

part 'read_news_state.dart';

class ReadNewsBloc extends Bloc<ReadNewsEvent, ReadNewsState> {
  ReadNewsBloc() : super(ReadNewsLoading()) {
    on<GetReadNews>(_onGetReadNews);
    on<AddReadNews>(_onAddToReadNews);
    on<DeleteReadNews>(_onDeleteReadNews);
  }

  final GetReadNewsUseCase _readNewsUseCase =
      GetReadNewsUseCase(repository: locator());
  final AddReadNewsUseCase _addReadNewsUseCase =
      AddReadNewsUseCase(repository: locator());
  final DeleteReadNewsUseCase _deleteReadNewsUseCase =
      DeleteReadNewsUseCase(repository: locator());

  Future<void> _onGetReadNews(
      GetReadNews event, Emitter<ReadNewsState> emit) async {
    final result = await _readNewsUseCase.execute(NoParams());

    result.fold((failure) {
      emit(ReadNewsError());
    }, (data) {
      if (data.isEmpty) {
        emit(ReadNewsEmpty());
      } else {
        emit(ReadNewsLoaded(data));
      }
    });
  }

  Future<void> _onAddToReadNews(
      AddReadNews event, Emitter<ReadNewsState> emit) async {
    final result = await _addReadNewsUseCase.execute(event.newsEntity);

    result.fold((failure) {
      emit(ReadNewsError());
    }, (data) {
      if (data) {
        add(GetReadNews());
      }
    });
  }

  Future<void> _onDeleteReadNews(
      DeleteReadNews event, Emitter<ReadNewsState> emit) async {
    final result = await _deleteReadNewsUseCase.execute(NoParams());

    result.fold((failure) {
      emit(ReadNewsError());
    }, (data) {
      if (data) {
        emit(ReadNewsEmpty());
      }
    });
  }
}
