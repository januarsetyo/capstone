import 'package:capstone/domain/entities/user.dart';

class UserModel {
  UserModel({
    required this.userId,
    required this.imageUrl,
  });

  final String userId;
  final String imageUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "imageUrl": imageUrl,
      };

  User toEntity() {
    return User(
      userId: this.userId,
      imageUrl: this.imageUrl,
    );
  }
}
