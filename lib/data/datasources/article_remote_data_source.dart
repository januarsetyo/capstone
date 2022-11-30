import 'dart:convert';

import 'package:capstone/data/models/article_model.dart';
import 'package:capstone/data/models/article_response.dart';
import 'package:capstone/utils/exception.dart';
import 'package:capstone/utils/constants.dart';

import 'package:http/http.dart' as http;

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getArticle();
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final http.Client client;

  ArticleRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ArticleModel>> getArticle() async {
    final response = await client.get(Uri.parse('$baseUrl/articles'));

    if (response.statusCode == 200) {
      return ArticleResponse.fromJson(json.decode(response.body)).articleList;
    } else {
      throw ServerException();
    }
  }
}
