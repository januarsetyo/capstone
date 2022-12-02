import 'package:capstone/presentation/pages/home_page.dart';
import 'package:capstone/presentation/provider/post_notifier.dart';
import 'package:capstone/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  static const routeName = '/postPage';

  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _auth = FirebaseAuth.instance;

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PostNotifier>(
        builder: (context, result, child) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Post To Forum',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: TextField(
                      controller: _descriptionController,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      minLines: 10,
                      maxLines: 15,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: primaryColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintText: 'Share your story here . . .',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Provider.of<PostNotifier>(context, listen: false)
                          .fetchCreatePost(
                        _auth.currentUser != null
                            ? _auth.currentUser!.email
                                .toString()
                                .replaceFirst('@gmail.com', '')
                            : '',
                        _descriptionController.text,
                      );

                      final snackBar = SnackBar(
                        content: Text(result.postMessage),
                        action: SnackBarAction(
                          label: 'Back To Home',
                          textColor: secondaryColor,
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              HomePage.routeName,
                            );
                          },
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    child:
                        Text('POST', style: Theme.of(context).textTheme.button),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
