import 'package:flutter/material.dart';
import 'package:news_app/core/constants/colors/app_colors.dart';
import 'package:news_app/features/domain/entities/comments_entity.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, required this.comment});

  final CommentsEntity comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, left: 16, right: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.cardColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.comment),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(comment.author),
              Text(comment.time),
            ],
          ),
        ],
      ),
    );
  }
}
