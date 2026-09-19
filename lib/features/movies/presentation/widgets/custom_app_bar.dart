import 'package:flutter/material.dart';
import 'package:paper_movies/features/movies/presentation/extensions/build_context.dart';

/// Created by Pratama Ramadhan on 19/09/26.

class CustomAppBar extends AppBar {
  final String titleText;
  CustomAppBar(BuildContext context, {super.key, required this.titleText})
    : super(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                context.colorScheme.primary,
                context.colorScheme.tertiary,
              ],
            ),
          ),
        ),
        title: Text(
          titleText,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        leading: const SizedBox.shrink(),
      );

  factory CustomAppBar.title(BuildContext context, {required String title}) {
    return CustomAppBar(context, titleText: title);
  }
}
