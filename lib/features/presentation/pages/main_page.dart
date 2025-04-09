import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/strings/app_strings.dart';
import 'package:news_app/features/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:news_app/features/presentation/blocs/news_bloc/news_bloc.dart';
import 'package:news_app/features/presentation/blocs/read_news_bloc/read_news_bloc.dart';
import 'package:news_app/features/presentation/pages/components/all_news.dart';
import 'package:news_app/features/presentation/widgets/k_footer.dart';
import 'package:news_app/features/presentation/widgets/main_button.dart';
import 'package:news_app/features/presentation/widgets/search_widget.dart';
import 'package:news_app/features/presentation/widgets/user_avatar_widget.dart';
import 'package:news_app/locator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'components/top_news.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  final newsBloc = locator<NewsBloc>();
  final authBloc = locator<AuthBloc>();

  int _currentPage = 1;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    newsBloc.add(GetTopNews(page: _currentPage));
    locator<ReadNewsBloc>().add(GetReadNews());
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    _currentPage = 1;
    newsBloc.add(GetTopNews(page: _currentPage));
    _refreshController.refreshCompleted();
  }

  void _onLoad() async {
    if (newsBloc.canLoad) {
      _currentPage++;
      newsBloc.add(GetTopNews(page: _currentPage));
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 130),
          child: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 20),
                child: GestureDetector(
                  onTap: showUser,
                  child: UserAvatarWidget(),
                ),
              )
            ],
            flexibleSpace: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 6),
                  child: Text(
                    AppStrings.appName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: SearchWidget(
                    searchCtrl: _searchCtrl,
                    onSearch: () {
                      setState(() {});
                      locator<NewsBloc>().add(SearchNews(_searchCtrl.text));
                    },
                    onClear: () {
                      setState(() {});
                      _searchCtrl.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                      locator<NewsBloc>().add(GetTopNews());
                    },
                  ),
                ),
                Divider()
              ],
            ),
          ),
        ),
        body: BlocListener<NewsBloc, NewsState>(
          listener: (context, state) {
            if (state is NewsLoaded ||
                state is NewsError ||
                state is NewsConnectionError) {
              _refreshController.refreshCompleted();
              _refreshController.loadComplete();
            }
          },
          child: SmartRefresher(
            controller: _refreshController,
            enablePullUp: newsBloc.canLoad,
            onLoading: _onLoad,
            onRefresh: _onRefresh,
            footer: KFooter(),
            child: CustomScrollView(
              slivers: [
                ReadNews(),
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    AppStrings.topNews,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )),
                AllNews(),
              ],
            ),
          ),
        ));
  }

  showUser() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(10),
            children: [
              SimpleDialogOption(
                child: Row(
                  children: [
                    UserAvatarWidget(),
                    SizedBox(width: 15),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is Authenticated) {
                          return Text(state.user!.email!);
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                child: MainButton(
                    buttonTile: AppStrings.signOut,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      authBloc.add(SignOutEvent());
                      Navigator.of(context).pop();
                    },
                    isLoading: false),
              ),
            ],
          );
        });
  }
}
