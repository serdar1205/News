import 'package:flutter/material.dart';
import 'package:news_app/core/constants/colors/app_colors.dart';
import 'package:news_app/core/constants/strings/app_strings.dart';

class ShowAllBtn extends StatelessWidget {
  const ShowAllBtn({super.key, required this.onTap, required this.title});

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          InkWell(
            splashColor: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(4),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.only(left: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppStrings.showAll,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.mainbuttonColor2)),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: AppColors.mainbuttonColor2,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
