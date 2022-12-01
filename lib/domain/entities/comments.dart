import 'package:equatable/equatable.dart';

class Comments extends Equatable {
  Comments({
    required this.createdAt,
    required this.updatedAt,
    required this.commentId,
    required this.name,
    required this.comments,
  });

  String createdAt;
  String updatedAt;
  int commentId;
  String name;
  String comments;

  @override
  List<Object> get props => [createdAt, updatedAt, commentId, name, comments];
}
