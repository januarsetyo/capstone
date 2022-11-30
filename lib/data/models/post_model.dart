import 'package:capstone/domain/entities/post.dart';

class PostModel {
  PostModel({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.description,
  });

  final String createdAt;
  final String updatedAt;
  final int id;
  final String name;
  final String description;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": id,
        "name": name,
        "description": description,
      };

  Post toEntity() {
    return Post(
      createdAt: this.createdAt,
      updatedAt: this.updatedAt,
      id: this.id,
      name: this.name,
      description: this.description,
    );
  }
}
