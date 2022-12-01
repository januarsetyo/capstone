import 'package:capstone/data/datasources/comments_remote_data_source.dart';
import 'package:capstone/domain/entities/article.dart';
import 'package:capstone/domain/entities/comments.dart';
import 'package:capstone/domain/usecases/get_comments_by_id.dart';
import 'package:capstone/utils/enum_state.dart';
import 'package:flutter/widgets.dart';

class CommentsNotifier extends ChangeNotifier {
  final GetCommentsById getCommentsById;

  CommentsNotifier(this.getCommentsById);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Comments> _comments = [];
  List<Comments> get comments => _comments;

  String _message = '';
  String get message => _message;

  Future<void> fetchComments(int commentId) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getCommentsById.execute(commentId);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
    }, (data) {
      _comments = data;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
