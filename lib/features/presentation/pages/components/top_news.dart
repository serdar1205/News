import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/network/internet_bloc/internet_bloc.dart';
import 'package:news_app/features/presentation/blocs/read_news_bloc/read_news_bloc.dart';
import 'package:news_app/features/presentation/widgets/last_read_news_list.dart';
import 'package:news_app/locator.dart';

class ReadNews extends StatelessWidget {
  const ReadNews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, internetState) {
        final newsState = context.read<ReadNewsBloc>().state;

        if (internetState is InternetConnected) {
          locator<ReadNewsBloc>().add(GetReadNews());
        } else {
          if (newsState is! ReadNewsLoaded) {
            locator<ReadNewsBloc>().add(GetReadNews());
          }
        }
      },
      child: BlocBuilder<ReadNewsBloc, ReadNewsState>(
        builder: (context, state) {
          return switch (state) {
            ReadNewsLoading() => SliverToBoxAdapter(
                child: SizedBox(),
              ),
            ReadNewsLoaded(:final data) =>
              LastReadNewsList(articlesEntity: data),
            ReadNewsError() => SliverToBoxAdapter(
                child: Center(
                  child: Text('Error'),
                ),
              ),
            ReadNewsEmpty() => SliverToBoxAdapter(
                child: SizedBox(),
              ),
          };
        },
      ),
    );
  }
}
