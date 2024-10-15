import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/community/read/community_read_event.dart';
import 'package:chuck2wiz/data/blocs/main/community/read/community_read_state.dart';
import 'package:chuck2wiz/data/db/shared_preferences_helper.dart';
import 'package:chuck2wiz/data/repository/article/article_repository.dart';
import 'package:chuck2wiz/data/repository/comment/comment_repository.dart';
import 'package:chuck2wiz/data/repository/auth/user_repository.dart';
import 'package:chuck2wiz/data/server/request/article/article_request.dart';
import 'package:chuck2wiz/data/server/vo/comment/comment_vo.dart';

class CommunityReadBloc extends Bloc<CommunityReadEvent, CommunityReadState> {
  final ArticleRepository articleRepository;
  final CommentRepository commentRepository;
  final UserRepository userRepository;
  
  CommunityReadBloc(
      this.articleRepository,
      this.commentRepository,
      this.userRepository) : super(CommunityReadInitial()) {
    on<GetArticleRead>(_onGetArticleRead);
    on<CommentWrite>(_onWriteComment);
    on<PostComment>(_onPostComment);
  }
  
  Future<void> _onGetArticleRead(GetArticleRead event, Emitter<CommunityReadState> emit) async{
    emit(state.copyWith(isLoading: true, articleId: event.articleId));
    
    try {
      final articleId = event.articleId;
      final userNum = await SharedPreferencesHelper.getUserNum();

      if(userNum == null) {
        throw Exception("userNum is NULL");
      }

      final response = await articleRepository.readArticle(articleId: articleId, userNum: userNum);

      emit(state.copyWith(articleReadResponse: response));
    } catch (e) {
      emit(CommunityReadFailure(error: e));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onWriteComment(CommentWrite event, Emitter<CommunityReadState> emit) async {
    emit(state.copyWith(comment: event.comment));
  }

  Future<void> _onPostComment(PostComment event, Emitter<CommunityReadState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final comment = state.comment;
      String? nick = await SharedPreferencesHelper.getNick();
      final userNum = await SharedPreferencesHelper.getUserNum();

      if(nick == null && userNum != null) {
        final response = await userRepository.getUserInfo(userNum: userNum);

        if(response.success) {
          nick = response.data.nick;
          await SharedPreferencesHelper.saveNick(nick);
        } else {
          throw Exception(response.message);
        }
      }

      final response = await commentRepository.postComment(
          CommentVo(
              postId: state.articleId ?? "",
              author: Author(userNum: userNum ?? "", nick: nick ?? ""),
              content: comment ?? ""
          )
      );

      if(response.success) {
        emit(CommentWriteSuccess(
            isLoading: state.isLoading,
            articleId: state.articleId,
            articleReadResponse: state.articleReadResponse,
            comment: ""
        ));
      }
    } catch(e) {
      emit(CommunityReadFailure(error: e));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

}