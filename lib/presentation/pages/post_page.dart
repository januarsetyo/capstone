import 'package:capstone/presentation/pages/home_page.dart';
import 'package:capstone/presentation/provider/post_notifier.dart';
import 'package:capstone/presentation/provider/user_notifier.dart';
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

  bool _isDescriptionFilled = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<UserNotifier>(context, listen: false)
        .fetchProfilePictureById(_auth.currentUser!.uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PostNotifier>(
        builder: (context, result, child) {
          return Consumer<UserNotifier>(
            builder: (context, user, child) {
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
                          decoration: InputDecoration(
                            enabled: true,
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            hintText: 'Share your story here . . .',
                            errorText: _isDescriptionFilled
                                ? null
                                : 'Description can\'t be empty',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _descriptionController.text.isEmpty
                                ? _isDescriptionFilled = false
                                : _isDescriptionFilled = true;
                          });

                          if (_isDescriptionFilled == true) {
                            final currentUser = user.userById;

                            if (currentUser != null) {
                              await Provider.of<PostNotifier>(context, listen: false)
                                  .fetchCreatePost(
                                _auth.currentUser != null
                                    ? _auth.currentUser!.email
                                        .toString()
                                        .replaceFirst('@gmail.com', '')
                                    : '',
                                _descriptionController.text,
                                currentUser.imageUrl,
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
                            } else {
                              await Provider.of<PostNotifier>(context, listen: false)
                                  .fetchCreatePost(
                                _auth.currentUser != null
                                    ? _auth.currentUser!.email
                                        .toString()
                                        .replaceFirst('@gmail.com', '')
                                    : '',
                                _descriptionController.text,
                                '',
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
                            }

                            _descriptionController.text = '';
                          } else {
                            _isDescriptionFilled = false;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        child: Text(
                          'POST',
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
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
