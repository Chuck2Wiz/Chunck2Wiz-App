import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/myArticles/my_articles_event.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/myArticles/my_articles_state.dart';
import 'package:chuck2wiz/data/repository/article/article_repository.dart';

import '../../../../db/shared_preferences_helper.dart';

class MyArticlesBloc extends Bloc<MyArticlesEvent, MyArticlesState> {
  final ArticleRepository articleRepository;

  MyArticlesBloc(this.articleRepository): super(MyArticlesInitial()){
    on<GetMyArticlesEvent>(_onGetMyArticles);
    on<ClickMyArticleEvent>(_onClickMyArticle);
  }

  Future<void> _onGetMyArticles(GetMyArticlesEvent event, Emitter<MyArticlesState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final page = event.page;
      final userNum = await SharedPreferencesHelper.getUserNum();

      if(userNum == null) {
        throw Exception("userNum is NULL");
      }

      final response = await articleRepository.getMyArticles(page: page, userNum: userNum);

      emit(state.copyWith(myArticleResponse: response));
    } catch(e) {
      emit(MyArticlesFailure(error: e));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClickMyArticle(ClickMyArticleEvent event, Emitter<MyArticlesState> emit) {
    emit(state.copyWith(clickArticleId: event.articleId));
  }
}