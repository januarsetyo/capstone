import 'package:capstone/domain/entities/article.dart';
import 'package:capstone/domain/entities/comments.dart';
import 'package:capstone/domain/entities/post.dart';
import 'package:capstone/presentation/pages/post_detail_page.dart';
import 'package:capstone/presentation/provider/post_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildArticleListTile(BuildContext context, Article article) {
  return ListTile(
    title: Text(article.title),
    subtitle: Text(article.description),
  );
}

Widget forumCard(BuildContext context, Post post) {
  final auth = FirebaseAuth.instance;
  final currentUsername = auth.currentUser != null
      ? auth.currentUser!.email.toString().replaceFirst('@gmail.com', '')
      : '';

  return Consumer<PostNotifier>(
    builder: (context, result, child) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        post.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_horiz),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  'WARNING !',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                                content:
                                    const Text('Are you sure want to delete this post ?'),
                                actions: [
                                  TextButton(
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.redAccent),
                                    ),
                                    onPressed: () async {
                                      if (post.name != currentUsername) {
                                        return showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: const [
                                                  Expanded(
                                                    child: Text(
                                                      'Can\'t delete other people post',
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: const Text('Back'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      }

                                      await Provider.of<PostNotifier>(context,
                                              listen: false)
                                          .fetchDeletePostById(post.id);

                                      final snackBar = SnackBar(
                                        content: Text(
                                          result.deleteMessage,
                                        ),
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);

                                      await Provider.of<PostNotifier>(context,
                                              listen: false)
                                          .fetchPost();

                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Back'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )
                    ],
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
            onTap: () {
              Navigator.pushNamed(
                context,
                PostDetailPage.routeName,
                arguments: post.id,
              );
            },
          ),
        ),
      );
    },
  );
}

Widget postDetailCard(BuildContext context, Post post) {
  return Card(
    color: Colors.white70,
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
  );
}

Widget commentsCard(BuildContext context, Comments comments) {
  return Card(
    color: Colors.white70,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comments.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(comments.createdAt),
          const SizedBox(
            height: 15,
          ),
          Text(comments.comments),
        ],
      ),
    ),
  );
}
