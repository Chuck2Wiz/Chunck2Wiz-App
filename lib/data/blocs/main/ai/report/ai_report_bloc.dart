import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_event.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_state.dart';
import 'package:chuck2wiz/data/db/shared_preferences_helper.dart';

class AiReportBloc extends Bloc<AiReportEvent, AiReportState> {
  AiReportBloc(): super(AiReportInitial()) {
    on<GetInitData>(_onGetInitData);
  }

  Future<void> _onGetInitData(GetInitData event, Emitter<AiReportState> emit) async{
    emit(state.copyWith(isLoading: true));

    try {
      final answerData = await SharedPreferencesHelper.getAnswerData();

      emit(state.copyWith(
          selectOption: event.selectOption,
          formData: event.formData,
          answerData: answerData));
    } catch(e) {
      emit(AiReportFailure(error: e));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}