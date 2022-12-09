import 'package:equatable/equatable.dart';

class Article extends Equatable {
  Article({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.title,
    required this.url,
  });

  String createdAt;
  String updatedAt;
  int id;
  String title;
  String url;

  @override
  List<Object> get props => [createdAt, updatedAt, id, title, url];
}
