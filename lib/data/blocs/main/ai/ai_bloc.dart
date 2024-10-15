import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/repository/ai/form_repository.dart';

import 'ai_event.dart';
import 'ai_state.dart';

class AiBloc extends Bloc<AiEvent, AiState> {
  final FormRepository formRepository;

  AiBloc(this.formRepository): super(AiInitial()) {
    on<GetFormOptionsEvent>(_onGetFormOptions);
    on<SelectOptionEvent>(_onClickOption);
  }

  Future<void> _onGetFormOptions(GetFormOptionsEvent event, Emitter<AiState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await formRepository.getFormOptions();

      if(response.success) {
        emit(state.copyWith(formOptions: response.data.responseForms));
      }else {
        throw Exception(response.message);
      }
    } catch(e) {
      emit(GetFormOptionsFailure(error: e));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onClickOption(SelectOptionEvent event, Emitter<AiState> emit) async {
    emit(state.copyWith(selectOption: event.selectOption));
  }
}