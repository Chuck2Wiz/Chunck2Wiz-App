import 'package:equatable/equatable.dart';

import '../../../../server/response/form/search_form_response.dart';

class AiFormState extends Equatable {
  final bool isLoading;
  final String? selectOption;
  final List<FormData>? formData;
  final String? questionValue;

  const AiFormState({this.isLoading = false, this.selectOption, this.formData, this.questionValue});

  AiFormState copyWith({
    bool? isLoading,
    String? selectOption,
    List<FormData>? formData,
    String? questionValue
  }) {
    return AiFormState(
      isLoading: isLoading ?? this.isLoading,
      selectOption: selectOption ?? this.selectOption,
      formData: formData ?? this.formData,
      questionValue: questionValue ?? this.questionValue
    );
  }

  @override
  List<Object?> get props => [isLoading, formData, selectOption];
}

class AiFormInitial extends AiFormState {}

class AiFormFailure extends AiFormState {
  final dynamic error;

  const AiFormFailure({super.isLoading, super.formData, this.error});
}