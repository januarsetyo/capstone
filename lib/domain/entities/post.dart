import 'package:equatable/equatable.dart';

class Post extends Equatable {
  Post({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.description,
  });

  String createdAt;
  String updatedAt;
  int id;
  String name;
  String description;

  @override
  List<Object> get props => [createdAt, updatedAt, id, name, description];
}
