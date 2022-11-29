import 'package:capstone/data/models/articles_model.dart';
import 'package:equatable/equatable.dart';

class ArticlesResponse extends Equatable {
  final List<ArticleModel> articleList;

  const ArticlesResponse({required this.articleList});

  factory ArticlesResponse.fromJson(Map<String, dynamic> json) => ArticlesResponse(
      articleList: List<ArticleModel>.from(
          (json["articles"] as List).map((x) => ArticleModel.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "articles": List<dynamic>.from(articleList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [articleList];
}
