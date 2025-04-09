import 'package:flutter/material.dart';

void dialogWidget(BuildContext context, String title) {
  showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          titlePadding: EdgeInsets.all(10),
          title: Text(title),

        );
      });
}