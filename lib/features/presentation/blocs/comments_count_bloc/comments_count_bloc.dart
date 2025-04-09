import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/domain/usecases/comments/get_comments_count_usecase.dart';
import 'package:news_app/locator.dart';

part 'comments_count_event.dart';

part 'comments_count_state.dart';

class CommentsCountBloc extends Bloc<CommentsCountEvent, CommentsCountState> {
  final GetCommentsCountUseCase _commentsCountUseCase =
      GetCommentsCountUseCase(repository: locator());

  CommentsCountBloc() : super(CommentsCountInitial()) {
    on<GetCommentsCount>(_onGetCommentCount);
  }

  Future<void> _onGetCommentCount(
      GetCommentsCount event, Emitter<CommentsCountState> emit) async {
    final result = await _commentsCountUseCase.execute(event.articleIds);

    result.fold((failure) {
      emit(CommentsCountError());
    }, (dataCounts) {
      if (dataCounts.isNotEmpty) {
        emit(CommentsCountLoaded(dataCounts));
      } else {
        emit(CommentsCountEmpty());
      }
    });
  }
}
