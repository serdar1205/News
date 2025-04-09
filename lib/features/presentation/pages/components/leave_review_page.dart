import 'package:flutter/material.dart';
import 'package:news_app/core/constants/strings/app_strings.dart';
import 'package:news_app/features/domain/usecases/comments/add_comment_usecase.dart';
import 'package:news_app/features/presentation/blocs/comments_bloc/comments_bloc.dart';
import 'package:news_app/locator.dart';
import '../../widgets/k_textfield.dart';

class LeaveReviewPage extends StatefulWidget {
  const LeaveReviewPage({super.key, required this.articleId});

  final String articleId;

  @override
  State<LeaveReviewPage> createState() => _LeaveReviewPageState();
}

class _LeaveReviewPageState extends State<LeaveReviewPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController reviewCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    reviewCtrl.dispose();
  }

  void createReview() {
    if (formKey.currentState?.validate() ?? false) {
      locator<CommentsBloc>().add(AddComment(
        CommentParams(
            articleId: widget.articleId, comment: reviewCtrl.text.trim()),
      ));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppStrings.back),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: createReview,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF486DFF),
                            Color(0xFFC053F8),
                          ])),
                  child: Text(AppStrings.send),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Form(
            key: formKey,
            child: KTextField(
                controller: reviewCtrl,
                isSubmitted: false,
                maxLines: 6,
                hintText: AppStrings.yourComment),
          )
        ],
      ),
    );
  }
}
