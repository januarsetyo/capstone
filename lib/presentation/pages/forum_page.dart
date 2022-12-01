import 'package:capstone/presentation/pages/post_page.dart';
import 'package:capstone/presentation/provider/post_notifier.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:capstone/styles/styles.dart';
import 'package:capstone/utils/enum_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForumPage extends StatefulWidget {
  static const String title = 'Forum';

  const ForumPage({Key? key}) : super(key: key);

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<PostNotifier>(context, listen: false).fetchPost());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.create,
              color: primaryColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, PostPage.routeName);
            },
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: Consumer<PostNotifier>(
        builder: (context, result, child) {
          if (result.state == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: secondaryColor,
              ),
            );
          } else if (result.state == RequestState.loaded) {
            return ListView.builder(
              itemCount: result.post.length,
              itemBuilder: (context, index) {
                var post = result.post.reversed.toList();
                var postReversed = post[index];

                return forumCard(context, postReversed);
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
