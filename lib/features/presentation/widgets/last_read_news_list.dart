import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/config/routes/routes_path.dart';
import 'package:news_app/core/constants/strings/app_strings.dart';
import 'package:news_app/features/domain/entities/top_news_entity.dart';
import 'shimmer_image.dart';
import 'show_all_btn.dart';

class LastReadNewsList extends StatelessWidget {
  const LastReadNewsList({
    super.key,
    required this.articlesEntity,
  });

  final List<ArticleEntity> articlesEntity;

  @override
  Widget build(BuildContext context) {
    final itemLength = articlesEntity.length > 5 ? 5 : articlesEntity.length;
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          ShowAllBtn(
            title: AppStrings.lastReadNews,
            onTap: () {
              context.push(AppRoutes.lastReadPage);
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 195.0,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 16),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: itemLength,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.push(AppRoutes.detailsPage,
                        extra: {'newsEntity': articlesEntity[index]});
                  },
                  child: Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 14, bottom: 10),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: ImageWithShimmer(
                            imageUrl: articlesEntity[index].urlToImage,
                            width: 140,
                            height: 140,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          articlesEntity[index].title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
