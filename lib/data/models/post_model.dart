import 'package:capstone/domain/entities/post.dart';

class PostModel {
  PostModel({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  final String createdAt;
  final String updatedAt;
  final int id;
  final String name;
  final String imageUrl;
  final String description;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": id,
        "name": name,
        "description": description,
        "imageUrl": imageUrl,
      };

  Post toEntity() {
    return Post(
      createdAt: this.createdAt,
      updatedAt: this.updatedAt,
      id: this.id,
      name: this.name,
      description: this.description,
      imageUrl: this.imageUrl,
    );
  }
}
