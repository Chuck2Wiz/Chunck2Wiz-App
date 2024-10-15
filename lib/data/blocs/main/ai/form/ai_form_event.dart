import 'package:equatable/equatable.dart';

class AiFormEvent extends Equatable{
  const AiFormEvent();

  @override
  List<Object?> get props => [];
}

class GetAiFormDataEvent extends AiFormEvent {}

class AiFormSelectOptionEvent extends AiFormEvent {
  final String selectOption;

  const AiFormSelectOptionEvent({required this.selectOption});
}

class QuestionValueChangeEvent extends AiFormEvent {
  final String questionValue;

  const QuestionValueChangeEvent({required this.questionValue});
}