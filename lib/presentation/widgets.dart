import 'package:capstone/domain/entities/article.dart';
import 'package:flutter/material.dart';

Widget buildArticleListTile(BuildContext context, Article article) {
  return ListTile(
    title: Text(article.title),
    subtitle: Text(article.description),
  );
}
