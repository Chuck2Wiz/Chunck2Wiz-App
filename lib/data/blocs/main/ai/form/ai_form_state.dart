import 'package:equatable/equatable.dart';

import '../../../../server/response/form/search_form_response.dart';

class AiFormState extends Equatable {
  final bool isLoading;
  final String? selectOption;
  final List<FormData>? formData;
  final bool isCompleteAnswer;

  const AiFormState({this.isLoading = false, this.selectOption, this.formData, this.isCompleteAnswer = false});

  AiFormState copyWith({
    bool? isLoading,
    String? selectOption,
    List<FormData>? formData,
    List<String>? answerData,
    bool? isCompleteAnswer
  }) {
    return AiFormState(
      isLoading: isLoading ?? this.isLoading,
      selectOption: selectOption ?? this.selectOption,
      formData: formData ?? this.formData,
      isCompleteAnswer: isCompleteAnswer ?? this.isCompleteAnswer,
    );
  }

  @override
  List<Object?> get props => [isLoading, formData, selectOption, isCompleteAnswer];
}

class AiFormInitial extends AiFormState {
  const AiFormInitial({super.isLoading, super.formData, super.selectOption});
}

class AiFormFailure extends AiFormState {
  final dynamic error;

  const AiFormFailure({super.isLoading, super.formData, super.selectOption, this.error});
}

class AiFormSuccess extends AiFormState {
  const AiFormSuccess({super.isLoading, super.formData, super.selectOption});
}