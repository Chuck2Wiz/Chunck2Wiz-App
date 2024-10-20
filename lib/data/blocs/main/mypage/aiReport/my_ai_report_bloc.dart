import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/aiReport/my_ai_report_event.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/aiReport/my_ai_report_state.dart';
import 'package:chuck2wiz/data/db/shared_preferences_helper.dart';
import 'package:chuck2wiz/data/repository/aiReport/ai_report_repository.dart';
import 'package:chuck2wiz/data/server/request/aiReport/ai_report_request.dart';
import 'package:get/get.dart';

class MyAiReportBloc extends Bloc<MyAiReportEvent, MyAiReportState> {
  final AiReportRepository aiReportRepository;


  MyAiReportBloc(this.aiReportRepository) : super(MyAiReportInitial()) {
    on<GetAiReportEvent>(_onGetAiReport);
    on<ClickAiReportEvent>(_onClickAiReport);
  }

  Future<void> _onGetAiReport(GetAiReportEvent event, Emitter<MyAiReportState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final userNum = await SharedPreferencesHelper.getUserNum();

      if(userNum == null) {
        throw Exception("UserNum is NULL");
      }

      final response = await AiReportRequest().getAiReport(userNum: userNum);

      if(response.success) {
        emit(state.copyWith(getAiReportResponse: response));
      } else {
        emit(MyAiReportFailure(error: response.message));
      }
    } catch(e) {
      e.printError();
      emit(MyAiReportFailure(error: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onClickAiReport(ClickAiReportEvent event, Emitter<MyAiReportState> emit) async {
    emit(state.copyWith(clickAiReportId: event.aiReportId));
  }

}