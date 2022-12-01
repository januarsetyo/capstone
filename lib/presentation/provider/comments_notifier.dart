import 'package:capstone/domain/entities/comments.dart';
import 'package:capstone/domain/usecases/create_comments.dart';
import 'package:capstone/domain/usecases/get_comments_by_id.dart';
import 'package:capstone/utils/enum_state.dart';
import 'package:flutter/widgets.dart';

class CommentsNotifier extends ChangeNotifier {
  final GetCommentsById getCommentsById;
  final CreateComments createComments;

  CommentsNotifier(this.getCommentsById, this.createComments);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _commentsMessage = '';
  String get commentMessage => _commentsMessage;

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

  Future<void> fetchCreateComments(int commentId, String name, String comments) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await createComments.execute(commentId, name, comments);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
    }, (data) {
      _commentsMessage = data;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
