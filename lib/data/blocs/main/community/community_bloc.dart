import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/community/community_event.dart';
import 'package:chuck2wiz/data/blocs/main/community/community_state.dart';
import 'package:chuck2wiz/data/db/shared_preferences_helper.dart';
import 'package:chuck2wiz/data/server/request/article/article_request.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  CommunityBloc() : super(CommunityInitial()) {
    on<GetArticles>(_onGetArticles);
    on<RefreshArticle>(_onRefreshArticles);
    on<ClickArticle>(_onClickArticle);
  }

  Future<void> _onGetArticles(GetArticles event, Emitter<CommunityState> emit) async {
    emit(CommunityInitial());
    emit(state.copyWith(isLoading: true));
    try {
      final page = event.page;
      final userNum = await SharedPreferencesHelper.getUserNum();

      if(userNum == null) {
        throw Exception("userNum is NULL");
      }

      final response = await ArticleRequest().getArticles(page: page, userNum: userNum);

      emit(CommunityState(articleGetResponse: response));
    } catch(e) {
      emit(CommunityFailure(error: e));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onRefreshArticles(RefreshArticle event, Emitter<CommunityState> emit) {
    emit(CommunityRefresh());
  }

  void _onClickArticle(ClickArticle event, Emitter<CommunityState> emit) {
    emit(state.copyWith(clickArticleId: event.articleId));
  }

}