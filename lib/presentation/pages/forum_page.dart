import 'package:capstone/presentation/provider/post_notifier.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:capstone/utils/enum_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForumPage extends StatelessWidget {
  static const String title = 'Forum';

  const ForumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: const [
          Icon(
            Icons.create,
            color: Colors.lightBlue,
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Consumer<PostNotifier>(
        builder: (context, result, child) {
          if (result.state == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (result.state == RequestState.loaded) {
            return ListView.builder(
              itemCount: result.post.length,
              itemBuilder: (context, index) {
                var post = result.post[index];

                return forumCard(context, post);
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
