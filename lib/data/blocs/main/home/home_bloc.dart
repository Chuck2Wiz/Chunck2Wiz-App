import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/home/home_event.dart';
import 'package:chuck2wiz/data/blocs/main/home/home_state.dart';
import 'package:chuck2wiz/data/db/shared_preferences_helper.dart';
import 'package:chuck2wiz/data/repository/aiReport/ai_report_repository.dart';
import 'package:chuck2wiz/data/repository/article/article_repository.dart';
import 'package:chuck2wiz/data/server/request/aiReport/ai_report_request.dart';

import '../../../server/request/article/article_request.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AiReportRepository aiReportRepository;
  final ArticleRepository articleRepository;

  HomeBloc(this.aiReportRepository, this.articleRepository) : super(HomeInitial()) {
    on<GetLoadHomeDataEvent>(_onGetHomeInitData);
    on<RefreshHomeEvent>(_onRefreshData);
  }

  Future<void> _onGetHomeInitData(GetLoadHomeDataEvent event, Emitter<HomeState> emit) async{
    emit(state.copyWith(isLoading: true));

    try {
      final userNum = await SharedPreferencesHelper.getUserNum();

      if(userNum == null) {
        throw Exception("UserNum is NULL");
      }

      final aiReportResponse = await AiReportRequest().getAiReport(userNum: userNum);
      emit(state.copyWith(getAiReportResponse: aiReportResponse));

      final articleResponse = await ArticleRequest().getArticles(page: 1, userNum: userNum);
      emit(state.copyWith(articleGetResponse: articleResponse));
    } catch(e) {
      emit(HomeLoadFailure(error: e, previousState: state));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onRefreshData(RefreshHomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeRefresh());
  }
}