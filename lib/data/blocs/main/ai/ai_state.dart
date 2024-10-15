import 'package:chuck2wiz/data/server/response/form/get_form_response.dart';
import 'package:chuck2wiz/data/server/response/form/search_form_response.dart';
import 'package:equatable/equatable.dart';

class AiState extends Equatable{
  final bool isLoading;
  final String? selectOption;
  final List<ResponseForm>? formOptions;
  final List<FormData>? formData;

  const AiState({this.isLoading = false, this.selectOption, this.formOptions, this.formData});

  AiState copyWith({
    bool? isLoading,
    List<ResponseForm>? formOptions,
    String? selectOption,
    List<FormData>? formData
  }) {
    return AiState(
      isLoading: isLoading ?? this.isLoading,
      selectOption: selectOption ?? this.selectOption,
      formOptions: formOptions ?? this.formOptions,
      formData: formData ?? this.formData
    );
  }

  @override
  List<Object?> get props => [isLoading, selectOption, formOptions, formData];
}

class AiInitial extends AiState {}

class GetFormOptions extends AiState {
  const GetFormOptions({
    super.isLoading,
    super.selectOption,
    super.formData,
    super.formOptions
  });
}

class GetFormOptionsFailure extends AiState {
  final dynamic error;

  const GetFormOptionsFailure({
    super.isLoading,
    super.selectOption,
    super.formOptions,
    super.formData,
    this.error
  });
}