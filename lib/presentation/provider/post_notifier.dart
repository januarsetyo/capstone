import 'package:capstone/domain/entities/post.dart';
import 'package:capstone/domain/usecases/create_post.dart';
import 'package:capstone/domain/usecases/get_post.dart';
import 'package:capstone/domain/usecases/get_post_by_id.dart';
import 'package:capstone/utils/enum_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class PostNotifier extends ChangeNotifier {
  final GetPost getPost;
  final CreatePost createPost;
  final GetPostById getPostById;

  final _auth = FirebaseAuth.instance;

  PostNotifier(this.getPost, this.createPost, this.getPostById) {
    fetchPost();
  }

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Post> _post = [];
  List<Post> get post => _post;

  Post _postById = Post(createdAt: '', updatedAt: '', id: 0, name: '', description: '');
  Post get postByid => _postById;

  String _postMessage = '';
  String get postMessage => _postMessage;

  String _message = '';
  String get message => _message;

  Future<void> fetchPost() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPost.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
    }, (data) {
      _post = data;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }

  Future<void> fetchPostByid(int id) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPostById.execute(id);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
    }, (data) {
      _postById = data;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }

  Future<void> fetchCreatePost(String username, String description) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await createPost.execute(username, description);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
    }, (data) {
      _postMessage = data;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
