import 'dart:convert';

import 'package:capstone/data/models/user_model.dart';
import 'package:capstone/utils/constants.dart';
import 'package:capstone/utils/exception.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<String> createProfilePicture(String userId, String imageUrl);
  Future<dynamic> getProfilePictureById(String userId);
  Future<String> deleteProfilePictureById(String userId);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<String> createProfilePicture(String userId, String imageUrl) async {
    final response = await client.post(
      Uri.parse('$baseUrl/user'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        <String, dynamic>{
          "userId": userId,
          "imageUrl": imageUrl,
        },
      ),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<dynamic> getProfilePictureById(String userId) async {
    final response = await client.get(Uri.parse('$baseUrl/user/$userId'));

    if (response.statusCode == 200) {
      if (json.decode(response.body) == null) {
        return null;
      } else {
        return UserModel.fromJson(json.decode(response.body));
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteProfilePictureById(String userId) async {
    final response = await client.delete(Uri.parse('$baseUrl/user/$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw ServerException();
    }
  }
}
