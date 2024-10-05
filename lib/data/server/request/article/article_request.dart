import 'dart:convert';

import 'package:chuck2wiz/data/http/base_http.dart';
import 'package:chuck2wiz/data/server/response/article/article_create_response.dart';
import 'package:chuck2wiz/data/server/response/article/article_get_response.dart';
import 'package:chuck2wiz/data/server/vo/article/ArticleCreateVo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ArticleRequest {
  static String BASE_URL = "${dotenv.env['API_URL']}/v1/articles";

  /**
   * post
   * */
  Future<ArticleCreateResponse> createArticle(ArticleCreateVo articleCreateVo) async {
    final url = Uri.parse(BASE_URL);

    try {
      final response= await BaseHttp().post(
          url.toString(),
          articleCreateVo
      );

      return ArticleCreateResponse.fromJson(jsonDecode(response));
    } catch(e) {
      print("error: $e");
      rethrow;
    }
  }

  /**
   * /:page
   * */
  Future<ArticleGetResponse> getArticles(int page) async{
    final url = Uri.parse('$BASE_URL/$page');

    try {
      final response = await BaseHttp().get(url.toString());

      return ArticleGetResponse.fromJson(jsonDecode(response));
    } catch(e) {
      print('error: $e');
      rethrow;
    }
  }
}