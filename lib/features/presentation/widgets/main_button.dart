import 'package:flutter/material.dart';
import 'package:news_app/core/constants/colors/app_colors.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.buttonTile,
    required this.onPressed,
    required this.isLoading,
    this.padding,
    this.alignment,
  });

  final String buttonTile;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          alignment: alignment,
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          decoration: BoxDecoration(
              color: AppColors.mainbuttonColor2,
              borderRadius: BorderRadius.circular(12)),
          child: isLoading
              ? const SizedBox(
                  height: 23,
                  width: 23,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: AppColors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  buttonTile,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                )),
    );
  }
}
