import 'package:flutter/material.dart';
import 'package:news_app/core/constants/colors/app_colors.dart';
import 'news_card_ui_model.dart';
import 'shimmer_image.dart';

class NewsCard extends StatelessWidget {
  final NewsCardUiModel news;
  final int? commentCount;
  final bool showComment;
  final VoidCallback? onTap;

  const NewsCard({
    super.key,
    required this.news,
    this.onTap,
    this.showComment = false,
    this.commentCount,
  });

  @override
  Widget build(BuildContext context) {
    final hasComment = (commentCount ?? 0) > 0;

    return Stack(
      children: [
        Container(
          height: 150,
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 2, 4),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: ImageWithShimmer(
                      imageUrl: news.image,
                      width: double.infinity,
                      height: 128,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.title,
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        news.body,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showComment && hasComment)
          Positioned(
              top: 20,
              left: 8,
              child: CircleAvatar(
                radius: 13,
                backgroundColor: AppColors.mainbuttonColor3,
                child: Text(
                  '$commentCount',
                  style: TextStyle(color: Colors.white),
                ),
              ))
      ],
    );
  }
}
