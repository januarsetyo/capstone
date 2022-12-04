import 'package:equatable/equatable.dart';

class Post extends Equatable {
  Post({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  String createdAt;
  String updatedAt;
  int id;
  String name;
  String description;
  String imageUrl;

  @override
  List<Object> get props => [createdAt, updatedAt, id, name, description, imageUrl];
}
