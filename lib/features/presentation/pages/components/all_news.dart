import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/config/routes/routes_path.dart';
import 'package:news_app/core/network/internet_bloc/internet_bloc.dart';
import 'package:news_app/features/presentation/blocs/comments_count_bloc/comments_count_bloc.dart';
import 'package:news_app/features/presentation/blocs/news_bloc/news_bloc.dart';
import 'package:news_app/features/presentation/widgets/all_news_card.dart';
import 'package:news_app/features/presentation/widgets/news_card_ui_model.dart';
import 'package:news_app/locator.dart';

class AllNews extends StatelessWidget {
  const AllNews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, internetState) {
        final newsState = context.read<NewsBloc>().state;

        if (internetState is InternetConnected) {
          locator<NewsBloc>().add(GetTopNews());
        } else {
          if (newsState is! NewsLoaded) {
            locator<NewsBloc>().add(GetTopNews());
          }
        }
      },
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          return switch (state) {
            NewsLoading() => SliverPadding(
                padding: EdgeInsets.only(top: 50),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            NewsLoaded(:final data) =>
              BlocBuilder<CommentsCountBloc, CommentsCountState>(
                builder: (context, countState) {
                  Map<String, int> commentCounts = {}; // Map<String, int>

                  if (countState is CommentsCountLoaded) {
                    commentCounts = countState.counts;
                  }

                  return SliverList.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final newsItem = data[index];

                      final commentCount = commentCounts[newsItem.title];

                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            context.push(AppRoutes.detailsPage,
                                extra: {'newsEntity': newsItem});
                          },
                          child: NewsCard(
                            news: NewsCardUiModel(
                              title: newsItem.title,
                              body: newsItem.description ?? '',
                              image: newsItem.urlToImage ,
                            ),
                            showComment: true,
                            commentCount: commentCount,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            NewsError() => SliverPadding(
                padding: EdgeInsets.only(top: 50),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text('Error'),
                  ),
                ),
              ),
            NewsConnectionError() => SliverPadding(
                padding: EdgeInsets.only(top: 50),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text('Connection error'),
                  ),
                ),
              ),
          };
        },
      ),
    );
  }
}
