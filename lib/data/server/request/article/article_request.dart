import 'dart:convert';

import 'package:chuck2wiz/data/http/base_http.dart';
import 'package:chuck2wiz/data/server/response/article/article_create_response.dart';
import 'package:chuck2wiz/data/server/response/article/article_get_response.dart';
import 'package:chuck2wiz/data/server/response/article/article_read_response.dart';
import 'package:chuck2wiz/data/server/vo/article/article_create_vo.dart';
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
  Future<ArticleGetResponse> getArticles({required int page, required String userNum}) async{
    final url = Uri.parse('$BASE_URL/$page/$userNum');

    try {
      final response = await BaseHttp().get(url.toString());

      return ArticleGetResponse.fromJson(jsonDecode(response));
    } catch(e) {
      print('error: $e');
      rethrow;
    }
  }

  /**
   * /id/:articleId
   * */
  Future<ArticleReadResponse> readArticle({required String articleId, required String userNum}) async{
    final url = Uri.parse('$BASE_URL/id/$articleId/$userNum');

    try {
      final response = await BaseHttp().get(url.toString());

      return ArticleReadResponse.fromJson(jsonDecode(response));
    } catch(e) {
      print('error: $e');
      rethrow;
    }
  }
}