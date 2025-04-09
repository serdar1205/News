import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/config/routes/routes_path.dart';
import 'package:news_app/core/constants/strings/app_strings.dart';
import 'package:news_app/core/network/internet_bloc/internet_bloc.dart';
import 'package:news_app/features/presentation/blocs/news_bloc/news_bloc.dart';
import 'package:news_app/features/presentation/blocs/read_news_bloc/read_news_bloc.dart';
import 'package:news_app/features/presentation/widgets/all_news_card.dart';
import 'package:news_app/features/presentation/widgets/news_card_ui_model.dart';
import 'package:news_app/locator.dart';

class AllReadNewsPage extends StatelessWidget {
  const AllReadNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.topNews),
        actions: [
          IconButton(
              onPressed: () {
                locator<ReadNewsBloc>().add(DeleteReadNews());
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: BlocListener<InternetBloc, InternetState>(
        listener: (context, internetState) {
          final newsState = context.read<ReadNewsBloc>().state;

          if (internetState is InternetConnected) {
            locator<ReadNewsBloc>().add(GetReadNews());
          } else {
            if (newsState is! NewsLoaded) {
              locator<ReadNewsBloc>().add(GetReadNews());
            }
          }
        },
        child: BlocBuilder<ReadNewsBloc, ReadNewsState>(
          builder: (context, state) {
            return switch (state) {
              ReadNewsLoading() => Center(
                  child: CircularProgressIndicator(),
                ),
              ReadNewsLoaded(:final data) => ListView.builder(
                  padding: const EdgeInsets.only(left: 16),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final newsItem = data[index];
                    return GestureDetector(
                      onTap: () {
                        context.push(AppRoutes.detailsPage,
                            extra: {'newsEntity': newsItem});
                      },
                      child: NewsCard(
                        news: NewsCardUiModel(
                          title: newsItem.title,
                          body: newsItem.description ?? '',
                          image: newsItem.urlToImage,
                        ),
                      ),
                    );
                  },
                ),
              ReadNewsError() => Center(
                  child: Text('Error'),
                ),
              ReadNewsEmpty() => Center(
                  child: Text('Empty'),
                ),
            };
          },
        ),
      ),
    );
  }
}
