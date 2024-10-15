import 'dart:convert';

import 'package:chuck2wiz/data/http/base_http.dart';
import 'package:chuck2wiz/data/server/response/article/article_create_response.dart';
import 'package:chuck2wiz/data/server/vo/comment/comment_vo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CommentRequest {
  static String BASE_URL = "${dotenv.env['API_URL']}/v1/comments";

  Future<ArticleCreateResponse> writeComment(CommentVo commentVo) async {
    final url = Uri.parse(BASE_URL);

    try {
      final response = await BaseHttp().post(
          url.toString(),
          commentVo.toJson()
      );

      return ArticleCreateResponse.fromJson(jsonDecode(response));
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}