import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/config/routes/routes_path.dart';
import 'package:news_app/features/domain/entities/top_news_entity.dart';
import 'package:news_app/features/presentation/pages/auth_pages/auth_gate.dart';
import 'package:news_app/features/presentation/pages/auth_pages/auth_page.dart';
import 'package:news_app/features/presentation/pages/details_page.dart';
import 'package:news_app/features/presentation/pages/main_page.dart';
import 'package:news_app/features/presentation/pages/splash_screen.dart';
import 'package:news_app/features/presentation/pages/all_read_news_page.dart';
import 'widget_keys_srt.dart';

final goRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  navigatorKey: rootNavKey,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.authCheckPage,
      builder: (context, state) {
        return AuthGate();
      },
    ),
    GoRoute(
      path: AppRoutes.mainPage,
      builder: (context, state) {
        return MainPage();
      },
    ),
    GoRoute(
      path: AppRoutes.loginOrRegister,
      builder: (context, state) {
        return AuthPage();
      },
    ),
    GoRoute(
      path: AppRoutes.detailsPage,
      builder: (context, state) {
        if (state.extra != null && state.extra is Map<String, dynamic>) {
          final extra = state.extra as Map<String, dynamic>;
          final ArticleEntity newsEntity = extra['newsEntity'];

          return DetailsPage(newsEntity: newsEntity);
        } else {
          return Scaffold(
              appBar: AppBar(),
              body: Center(child: Text('Not available this page')));
        }
      },
    ),
    GoRoute(
      path: AppRoutes.lastReadPage,
      builder: (context, state) {
        return AllReadNewsPage();
      },
    ),
  ],
);
