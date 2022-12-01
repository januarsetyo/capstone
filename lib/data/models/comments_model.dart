import 'package:capstone/domain/entities/comments.dart';

class CommentsModel {
  CommentsModel({
    required this.createdAt,
    required this.updatedAt,
    required this.commentId,
    required this.name,
    required this.comments,
  });

  final String createdAt;
  final String updatedAt;
  final int commentId;
  final String name;
  final String comments;

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        commentId: json["commentId"],
        name: json["name"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "commentId": commentId,
        "name": name,
        "comments": comments,
      };

  Comments toEntity() {
    return Comments(
      createdAt: this.createdAt,
      updatedAt: this.updatedAt,
      commentId: this.commentId,
      name: this.name,
      comments: this.comments,
    );
  }
}
