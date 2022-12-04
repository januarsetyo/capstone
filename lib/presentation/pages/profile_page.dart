import 'dart:io' as i;
import 'package:capstone/presentation/provider/user_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import 'package:capstone/presentation/pages/login_page.dart';
import 'package:capstone/presentation/provider/preferences_notifier.dart';
import 'package:capstone/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static const String title = 'Profile';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<UserNotifier>(context, listen: false)
        .fetchProfilePictureById(_auth.currentUser!.uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PreferencesNotifier>(
        builder: (context, prefs, child) {
          return Consumer<UserNotifier>(
            builder: (context, user, child) {
              final currentUser = user.userById;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (currentUser != null)
                        ? Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: primaryColor,
                                width: 3,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(currentUser.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: primaryColor,
                                width: 3,
                              ),
                              image: const DecorationImage(
                                image: AssetImage('assets/blank_profile.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      _auth.currentUser != null
                          ? _auth.currentUser!.email.toString()
                          : '',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      _auth.currentUser != null ? _auth.currentUser!.uid : '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () async {
                        XFile file = await getImage();
                        final imagePath = await uploadProfilePicture(file);

                        await Provider.of<UserNotifier>(context, listen: false)
                            .fetchCreateProfilePicture(
                          _auth.currentUser!.uid,
                          imagePath,
                        );

                        Provider.of<UserNotifier>(context, listen: false)
                            .fetchProfilePictureById(_auth.currentUser!.uid);

                        final snackBar = SnackBar(
                          content: Text(
                            user.profilePictureMessage,
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: const Text('Change Profile Picture'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () async {
                        final navigator = Navigator.of(context);

                        await _auth.signOut();
                        prefs.setIsLogin(false);

                        navigator.pushReplacementNamed(LoginPage.routeName);
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<String> uploadProfilePicture(XFile imageFile) async {
    String fileName = path.basename(imageFile.path);
    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(i.File(imageFile.path));

    return uploadTask.then((res) => res.ref.getDownloadURL());
  }

  Future getImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }
}
