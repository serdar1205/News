import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/constants/colors/app_colors.dart';
import 'package:news_app/core/constants/strings/app_strings.dart';
import 'package:news_app/core/constants/strings/assets_manager.dart';
import 'package:news_app/features/presentation/pages/components/leave_review_page.dart';

class CommentBtn extends StatefulWidget {
  const CommentBtn({
    super.key,
    required this.articleId,
  });

  final String articleId;

  @override
  State<CommentBtn> createState() => _CommentBtnState();
}

class _CommentBtnState extends State<CommentBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.cardColor,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: _addComment,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  IconsAssets.comment,
                  height: 24,
                  width: 24,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                AppStrings.addComment,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addComment() {
    showModalBottomSheet(
        useSafeArea: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        context: context,
        builder: (ctx) => LeaveReviewPage(articleId: widget.articleId));
  }
}
