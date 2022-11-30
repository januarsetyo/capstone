import 'package:capstone/domain/entities/article.dart';
import 'package:capstone/domain/entities/post.dart';
import 'package:flutter/material.dart';

Widget buildArticleListTile(BuildContext context, Article article) {
  return ListTile(
    title: Text(article.title),
    subtitle: Text(article.description),
  );
}

Widget forumCard(BuildContext context, Post post) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      color: Colors.white70,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(post.createdAt),
              const SizedBox(
                height: 15,
              ),
              Text(post.description),
            ],
          ),
        ),
        onTap: () {},
      ),
    ),
  );
}
