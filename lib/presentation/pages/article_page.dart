import 'package:capstone/presentation/provider/article_notifier.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:capstone/styles/styles.dart';
import 'package:capstone/utils/enum_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatelessWidget {
  static const String title = 'Article';

  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ArticleNotifier>(
        builder: (context, result, child) {
          if (result.state == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: secondaryColor,
              ),
            );
          } else if (result.state == RequestState.loaded) {
            return ListView.builder(
              itemCount: result.article.length,
              itemBuilder: (context, index) {
                var article = result.article[index];

                return buildArticleListTile(context, article);
              },
            );
          } else if (result.state == RequestState.error) {
            return Center(
              child: Text(result.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
