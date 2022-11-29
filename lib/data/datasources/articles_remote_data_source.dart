import 'dart:convert';

import 'package:capstone/data/models/articles_model.dart';
import 'package:capstone/data/models/articles_response.dart';
import 'package:capstone/utils/exception.dart';
import 'package:http/http.dart' as http;

abstract class ArticlesRemoteDataSource {
  Future<List<ArticleModel>> getArticle();
}

class ArticlesRemoteDataSourceImpl implements ArticlesRemoteDataSource {
  static const baseUrl = '';

  final http.Client client;

  ArticlesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ArticleModel>> getArticle() async {
    final response = await client.get(Uri.parse('$baseUrl/'));

    if (response.statusCode == 200) {
      return ArticlesResponse.fromJson(json.decode(response.body)).articleList;
    } else {
      throw ServerException();
    }
  }
}
