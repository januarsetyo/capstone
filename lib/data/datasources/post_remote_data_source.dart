import 'dart:convert';

import 'package:capstone/data/models/post_model.dart';
import 'package:capstone/utils/constants.dart';
import 'package:capstone/utils/exception.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPost();
  Future<String> createPost(String username, String description);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getPost() async {
    final response = await client.get(Uri.parse('$baseUrl/post'));

    if (response.statusCode == 200) {
      return List<PostModel>.from(
          json.decode(response.body).map((x) => PostModel.fromJson(x)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> createPost(String username, String description) async {
    final response = await client.post(
      Uri.parse('$baseUrl/post'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{"name": username, "description": description}),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw ServerException();
    }
  }
}
