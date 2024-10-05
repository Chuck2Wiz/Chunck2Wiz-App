import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/community/community_event.dart';
import 'package:chuck2wiz/data/blocs/main/community/community_state.dart';
import 'package:chuck2wiz/data/server/request/article/article_request.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  CommunityBloc() : super(CommunityInitial()) {
    on<GetArticles>(_onGetArticles);
  }

  Future<void> _onGetArticles(GetArticles event, Emitter<CommunityState> emit) async {
    emit(CommunityLoading());
    try {
      final page = event.page;
      final response = await ArticleRequest().getArticles(page);

      emit(CommunityState(articleGetResponse: response));
    } catch(e) {
      print("communityBloc getArticles Error: $e");
      emit(CommunityFailure(error: e));
    }
  }

}