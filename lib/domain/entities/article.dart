import 'package:equatable/equatable.dart';

class Article extends Equatable {
  Article({
    required this.title,
    required this.description,
  });

  String title;
  String description;

  @override
  List<Object?> get props => [
        title,
        description,
      ];
}
