import 'package:equatable/equatable.dart';

import '../../../../server/response/form/search_form_response.dart';

class AiReportState extends Equatable {
  final bool? isLoading;
  final String? selectOption;
  final List<FormData>? formData;
  final List<String>? answerData;

  const AiReportState({this.isLoading = false, this.selectOption, this.formData, this.answerData});

  AiReportState copyWith({
    bool? isLoading,
    String? selectOption,
    List<FormData>? formData,
    List<String>? answerData
  }) {
    return AiReportState(
      isLoading: isLoading ?? this.isLoading,
      selectOption: selectOption ?? this.selectOption,
      formData: formData ?? this.formData,
      answerData: answerData ?? this.answerData
    );
  }

  @override
  List<Object?> get props => [isLoading, selectOption, formData, answerData];
}

class AiReportInitial extends AiReportState {}

class AiReportFailure extends AiReportState {
  final dynamic error;

  const AiReportFailure({required this.error});
}