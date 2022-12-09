import 'package:capstone/domain/entities/comments.dart';
import 'package:capstone/domain/entities/post.dart';
import 'package:capstone/presentation/pages/post_detail_page.dart';
import 'package:capstone/presentation/provider/post_notifier.dart';
import 'package:capstone/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget forumCard(BuildContext context, Post post) {
  final auth = FirebaseAuth.instance;
  final currentUsername = auth.currentUser != null
      ? auth.currentUser!.email.toString().replaceFirst('@gmail.com', '')
      : '';

  return Consumer<PostNotifier>(
    builder: (context, result, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Card(
          color: Colors.lightBlue[100],
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          (post.imageUrl.isEmpty)
                              ? Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: primaryColor,
                                      width: 1,
                                    ),
                                    image: const DecorationImage(
                                      image: AssetImage('assets/blank_profile.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: primaryColor,
                                      width: 1,
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(post.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            post.name,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
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
                                  style: TextStyle(color: Colors.red),
                                ),
                                content:
                                    const Text('Are you sure want to delete this post ?'),
                                actions: [
                                  TextButton(
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () async {
                                      if (post.name != currentUsername) {
                                        Navigator.pop(context);

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
                  Text(
                    post.createdAt,
                    style: Theme.of(context).textTheme.overline,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    post.description,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
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
    color: Colors.lightBlue[100],
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            post.createdAt,
            style: Theme.of(context).textTheme.overline,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            post.description,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    ),
  );
}

Widget commentsCard(BuildContext context, Comments comments) {
  return Card(
    color: Colors.lightBlue[100],
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comments.name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            comments.createdAt,
            style: Theme.of(context).textTheme.overline,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            comments.comments,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    ),
  );
}

Card buildShortAppBar(BuildContext context) {
  return Card(
    margin: const EdgeInsets.all(0),
    shape: const BeveledRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(16),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Text(
            'Curhatin',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    ),
  );
}

class CustomScaffold extends StatelessWidget {
  final Widget body;

  const CustomScaffold({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            body,
            buildShortAppBar(context),
          ],
        ),
      ),
    );
  }
}
