import 'package:equatable/equatable.dart';

class AiEvent extends Equatable {
  const AiEvent();

  @override
  List<Object?> get props => [];
}

class GetFormOptionsEvent extends AiEvent {}

class SelectOptionEvent extends AiEvent {
  final String selectOption;

  const SelectOptionEvent({required this.selectOption});
}