import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/read/read_ai_report_event.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/read/read_ai_report_state.dart';
import 'package:chuck2wiz/data/db/shared_preferences_helper.dart';
import 'package:chuck2wiz/data/repository/aiReport/ai_report_repository.dart';
import 'package:chuck2wiz/data/server/request/aiReport/ai_report_request.dart';

class ReadAiReportBloc extends Bloc<ReadAiReportEvent, ReadAiReportState> {
  final AiReportRepository aiReportRepository;

  ReadAiReportBloc(this.aiReportRepository): super(ReadAiReportInitial()) {
    on<GetAiReportReadEvent>(_onGetAiReportRead);
  }

  Future<void> _onGetAiReportRead(GetAiReportReadEvent event, Emitter<ReadAiReportState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final aiReportId = event.aiReportId;
      final userNum = await SharedPreferencesHelper.getUserNum();

      if(userNum == null) {
        throw Exception("UserNum is NULL");
      }

      final response = await AiReportRequest().getReadAiReport(userNum: userNum, aiReportId: aiReportId);

      if(response.success) {
        emit(state.copyWith(getReadAiReportResponse: response));
      } else {
        emit(ReadAiReportFailure());
      }
    } catch(e) {
      emit(ReadAiReportFailure());
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}