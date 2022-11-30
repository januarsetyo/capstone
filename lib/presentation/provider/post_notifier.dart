import 'package:capstone/domain/entities/post.dart';
import 'package:capstone/domain/usecases/get_post.dart';
import 'package:capstone/utils/enum_state.dart';
import 'package:flutter/widgets.dart';

class PostNotifier extends ChangeNotifier {
  final GetPost getPost;

  PostNotifier(this.getPost) {
    fetchPost();
  }

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Post> _post = [];
  List<Post> get post => _post;

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
}
