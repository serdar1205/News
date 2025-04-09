import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/network/internet_bloc/internet_bloc.dart';
import 'package:news_app/features/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:news_app/features/presentation/blocs/news_bloc/news_bloc.dart';
import 'core/config/routes/app_router.dart';
import 'core/config/theme/app_theme.dart';
import 'core/constants/strings/app_strings.dart';
import 'features/presentation/blocs/comments_bloc/comments_bloc.dart';
import 'features/presentation/blocs/comments_count_bloc/comments_count_bloc.dart';
import 'features/presentation/blocs/read_news_bloc/read_news_bloc.dart';
import 'locator.dart';

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<InternetBloc>(
              create: (context) => locator<InternetBloc>()),
          BlocProvider<AuthBloc>(create: (context) => locator<AuthBloc>()),
          BlocProvider<ReadNewsBloc>(
              create: (context) => locator<ReadNewsBloc>()),
          BlocProvider<NewsBloc>(create: (context) => locator<NewsBloc>()),
          BlocProvider<CommentsBloc>(
              create: (context) => locator<CommentsBloc>()),
          BlocProvider<CommentsCountBloc>(
              create: (context) => locator<CommentsCountBloc>()),
        ],
        child: MaterialApp.router(
          title: AppStrings.appName,
          theme: AppTheme.lightTheme(),
          debugShowCheckedModeBanner: false,
          routerConfig: goRouter,
        ));
  }
}
