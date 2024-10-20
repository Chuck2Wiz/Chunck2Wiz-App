import 'package:equatable/equatable.dart';

import '../../../../server/response/form/search_form_response.dart';

class AiReportEvent extends Equatable{
  const AiReportEvent();

  @override
  List<Object?> get props => [];
}

class GetInitData extends AiReportEvent {
  final String? selectOption;
  final List<FormData>? formData;

  const GetInitData({required this.formData, required this.selectOption});

  @override
  List<Object?> get props => [selectOption, formData];
}

class AiStreamAnswerData extends AiReportEvent {
  final String question;

  const AiStreamAnswerData({required this.question});
}

class QuestionEvent extends AiReportEvent {
  final String question;

  const QuestionEvent({required this.question});
}

class SaveAiReportEvent extends AiReportEvent {
  final String aiAnswer;

  const SaveAiReportEvent({required this.aiAnswer});
}


