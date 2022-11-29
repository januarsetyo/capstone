import 'package:equatable/equatable.dart';

class ArticlesModel {
  ArticlesModel({
    required this.message,
    required this.articles,
  });

  String message;
  List<ArticleModel> articles;

  factory ArticlesModel.fromJson(Map<String, dynamic> json) => ArticlesModel(
        message: json["message"],
        articles: List<ArticleModel>.from(
            json["articles"].map((x) => ArticleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class ArticleModel extends Equatable {
  const ArticleModel({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };

  ArticleModel toEntity() {
    return ArticleModel(
      title: this.title,
      description: this.description,
    );
  }

  @override
  List<Object> get props => [
        title,
        description,
      ];
}
