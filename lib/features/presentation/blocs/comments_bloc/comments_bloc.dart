import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/domain/entities/comments_entity.dart';
import 'package:news_app/features/domain/usecases/comments/add_comment_usecase.dart';
import 'package:news_app/features/domain/usecases/comments/get_comments_usecase.dart';
import 'package:news_app/locator.dart';

part 'comments_event.dart';

part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final GetCommentsUseCase _getCommentsUseCase =
      GetCommentsUseCase(repository: locator());
  final AddCommentUseCase _addCommentUseCase =
      AddCommentUseCase(repository: locator());

  CommentsBloc() : super(CommentsLoading()) {
    on<AddComment>(_onAddComment);
    on<GetComments>(_onGetComment);
  }

  Future<void> _onAddComment(
      AddComment event, Emitter<CommentsState> emit) async {
    final result = await _addCommentUseCase.execute(event.comment);

    result.fold((failure) {
      emit(CommentsError());
    }, (success) {
      emit(CommentsLoaded(success));
    });
  }

  Future<void> _onGetComment(
      GetComments event, Emitter<CommentsState> emit) async {
    emit(CommentsLoading());
    try {
      await emit.forEach(
        _getCommentsUseCase.execute(event.articleId),
        onData: (either) => either.fold(
          (failure) {
            if (failure is EmptyCacheFailure) {
              return CommentsEmpty(); // custom state for no cached data
            } else {
              return CommentsError(); // server/network error
            }
          },
          (comments) => CommentsLoaded(comments),
        ),
        onError: (_, __) => CommentsError(),
      );
    } catch (e) {
      emit(CommentsError());
    }
  }

}
