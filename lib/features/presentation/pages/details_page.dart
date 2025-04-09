import 'package:flutter/material.dart';
import 'package:news_app/core/constants/colors/app_colors.dart';
import 'package:news_app/core/constants/strings/app_strings.dart';
import 'package:news_app/core/utils/time_format.dart';
import 'package:news_app/features/domain/entities/top_news_entity.dart';
import 'package:news_app/features/presentation/blocs/comments_bloc/comments_bloc.dart';
import 'package:news_app/features/presentation/blocs/read_news_bloc/read_news_bloc.dart';
import 'package:news_app/features/presentation/widgets/comment_btn.dart';
import 'package:news_app/features/presentation/widgets/shimmer_image.dart';
import 'package:news_app/locator.dart';
import 'components/comments_list.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    super.key,
    required this.newsEntity,
  });

  final ArticleEntity newsEntity;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final formKey = GlobalKey<FormState>();

  final commentsBloc = locator<CommentsBloc>();
  final readNewsBloc =  locator<ReadNewsBloc>();

  @override
  void initState() {
    super.initState();
    commentsBloc.add(GetComments(widget.newsEntity.title));
    readNewsBloc.add(AddReadNews(widget.newsEntity));
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Stack(
              children: [
                ImageWithShimmer(
                  imageUrl: widget.newsEntity.urlToImage,
                  width: double.infinity,
                  height: 400,
                ),
                Positioned(
                  top: 30,
                  left: 15,
                  child: CircleAvatar(
                    backgroundColor: AppColors.formBG.withAlpha(150),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).appBarTheme.iconTheme?.color,
                        )),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: Text(
                widget.newsEntity.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Text(
                widget.newsEntity.description ?? '',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Text(
                widget.newsEntity.content ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Text(
                '${AppStrings.by}:\t ${widget.newsEntity.author}  ${widget.newsEntity.source.name}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
              child: Text(
                '${AppStrings.publishedDate}\t${formatPublishedDate(widget.newsEntity.publishedAt)}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            CommentBtn(
              articleId: widget.newsEntity.title,
            ),
            SizedBox(height: 20),
          ])),
          CommentsList(),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
