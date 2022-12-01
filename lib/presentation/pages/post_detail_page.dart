import 'package:capstone/presentation/provider/comments_notifier.dart';
import 'package:capstone/presentation/provider/post_notifier.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:capstone/styles/styles.dart';
import 'package:capstone/utils/enum_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetailPage extends StatefulWidget {
  static const String routeName = '/postDetail';

  final int id;

  const PostDetailPage(this.id, {Key? key}) : super(key: key);

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<PostNotifier>(context, listen: false).fetchPostByid(widget.id);
      Provider.of<CommentsNotifier>(context, listen: false).fetchComments(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<PostNotifier>(
          builder: (context, result, child) {
            if (result.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              );
            } else if (result.state == RequestState.loaded) {
              return Consumer<CommentsNotifier>(
                builder: (context, resultComments, child) {
                  if (resultComments.state == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: secondaryColor,
                      ),
                    );
                  } else if (resultComments.state == RequestState.loaded) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                postDetailCard(context, result.postByid),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    'Comments',
                                    style: Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: resultComments.comments.length,
                              itemBuilder: (context, index) {
                                var comment = resultComments.comments[index];

                                return commentsCard(context, comment);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (resultComments.state == RequestState.error) {
                    return Center(
                      child: Text(resultComments.message),
                    );
                  } else {
                    return Container();
                  }
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
      ),
    );
  }
}
