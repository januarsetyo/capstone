import 'package:capstone/domain/entities/article.dart';

class ArticleModel {
  ArticleModel({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.title,
    required this.url,
  });

  final String createdAt;
  final String updatedAt;
  final int id;
  final String title;
  final String url;

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": id,
        "title": title,
        "url": url,
      };

  Article toEntity() {
    return Article(
      createdAt: this.createdAt,
      updatedAt: this.updatedAt,
      id: this.id,
      title: this.title,
      url: this.url,
    );
  }
}
