import 'package:equatable/equatable.dart';

class User extends Equatable {
  User({
    required this.userId,
    required this.imageUrl,
  });

  String userId;
  String imageUrl;

  @override
  List<Object> get props => [userId, imageUrl];
}
