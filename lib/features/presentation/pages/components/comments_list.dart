import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/presentation/blocs/comments_bloc/comments_bloc.dart';

import '../../widgets/comment_card.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsBloc, CommentsState>(
        builder: (context, state) {
          return switch (state){
            CommentsLoading() =>
                SliverToBoxAdapter(child: Center(
                  child: Text('Loading'),
                ),),
            CommentsLoaded(:final data) =>
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          return CommentCard(comment: data[index]);
                        }, childCount: data.length
                    )),
            CommentsError() =>
                SliverToBoxAdapter(child: Center(
                  child: Text('Can\'t load comments'),
                ),),
            CommentsEmpty() => SliverToBoxAdapter(child: SizedBox()),
          };
        });
  }
}
