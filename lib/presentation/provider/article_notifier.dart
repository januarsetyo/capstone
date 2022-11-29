import 'package:capstone/domain/entities/article.dart';
import 'package:capstone/domain/usecases/get_article.dart';
import 'package:capstone/utils/enum_state.dart';
import 'package:flutter/widgets.dart';

class ArticleNotifier extends ChangeNotifier {
  final GetArticle getArticle;

  ArticleNotifier(this.getArticle) {
    fetchArticle();
  }

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Article> _article = [];
  List<Article> get article => _article;

  String _message = '';
  String get message => _message;

  Future<void> fetchArticle() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getArticle.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
    }, (data) {
      _article = data;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
