import 'package:chuck2wiz/data/server/request/article/article_request.dart';
import 'package:chuck2wiz/data/server/response/article/article_create_response.dart';
import 'package:chuck2wiz/data/server/response/article/article_read_response.dart';
import 'package:chuck2wiz/data/server/response/article/my_articles_response.dart';
import 'package:chuck2wiz/data/server/vo/article/article_create_vo.dart';

class ArticleRepository {
  Future<ArticleCreateResponse> createArticle(ArticleCreateVo articleCreateVo) async {
    return ArticleRequest().createArticle(articleCreateVo);
  }

  Future<ArticleReadResponse> readArticle({required String articleId, required String userNum}) async {
    return ArticleRequest().readArticle(articleId: articleId, userNum: userNum);
  }

  Future<MyArticlesResponse> getMyArticles({required int page, required String userNum}) async {
    return ArticleRequest().getMyArticles(page: page, userNum: userNum);
  }
}