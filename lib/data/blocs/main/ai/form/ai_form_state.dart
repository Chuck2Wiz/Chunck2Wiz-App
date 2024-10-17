import 'package:equatable/equatable.dart';

import '../../../../server/response/form/search_form_response.dart';

class AiFormState extends Equatable {
  final bool isLoading;
  final String? selectOption;
  final List<FormData>? formData;

  const AiFormState({this.isLoading = false, this.selectOption, this.formData});

  AiFormState copyWith({
    bool? isLoading,
    String? selectOption,
    List<FormData>? formData,
    List<String>? answerData
  }) {
    return AiFormState(
      isLoading: isLoading ?? this.isLoading,
      selectOption: selectOption ?? this.selectOption,
      formData: formData ?? this.formData,
    );
  }

  @override
  List<Object?> get props => [isLoading, formData, selectOption];
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