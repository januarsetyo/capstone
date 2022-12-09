import 'package:capstone/presentation/pages/article_webview_page.dart';
import 'package:capstone/presentation/provider/article_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatefulWidget {
  static const String title = 'Article';

  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<ArticleNotifier>(context, listen: false).fetchArticle());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleNotifier>(
      builder: (context, result, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Article',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: result.article.length,
                    itemBuilder: (context, index) {
                      var article = result.article[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(article.title),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ArticleWebViewPage.routeName,
                                arguments: article.url,
                              );
                            },
                          ),
                          const Divider(
                            height: 3,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
