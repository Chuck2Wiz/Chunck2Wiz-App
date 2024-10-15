import 'package:chuck2wiz/data/server/request/comment/comment_request.dart';
import 'package:chuck2wiz/data/server/response/article/article_create_response.dart';
import 'package:chuck2wiz/data/server/vo/comment/comment_vo.dart';

class CommentRepository {
  Future<ArticleCreateResponse> postComment(CommentVo commentVo) async {
    return CommentRequest().writeComment(commentVo);
  }
}