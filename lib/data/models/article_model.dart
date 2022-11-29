import 'package:capstone/domain/entities/article.dart';
import 'package:equatable/equatable.dart';

class ArticleModel extends Equatable {
  ArticleModel({
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

  Article toEntity() {
    return Article(
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
