import 'package:equatable/equatable.dart';

class Article extends Equatable {
  const Article({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  List<Object> get props => [
        title,
        description,
      ];
}
