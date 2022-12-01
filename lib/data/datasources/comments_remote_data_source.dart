import 'dart:convert';

import 'package:capstone/data/models/comments_model.dart';
import 'package:capstone/utils/constants.dart';
import 'package:capstone/utils/exception.dart';
import 'package:http/http.dart' as http;

abstract class CommentsRemoteDataSource {
  Future<List<CommentsModel>> getCommentsById(int commentId);
  Future<String> createComments(int commentId, String name, String comments);
}

class CommentsRemoteDataSourceImpl implements CommentsRemoteDataSource {
  final http.Client client;

  CommentsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CommentsModel>> getCommentsById(int commentId) async {
    final response = await client.get(Uri.parse('$baseUrl/comments/$commentId'));

    if (response.statusCode == 200) {
      return List<CommentsModel>.from(
          json.decode(response.body).map((x) => CommentsModel.fromJson(x)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> createComments(int commentId, String name, String comments) async {
    final response = await client.post(
      Uri.parse('$baseUrl/comments'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, dynamic>{
          "commentId": commentId,
          "name": name,
          "comments": comments,
        },
      ),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw ServerException();
    }
  }
}
