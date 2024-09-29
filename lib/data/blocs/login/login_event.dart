import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithKakao extends LoginEvent {}

class LoginWithNaver extends LoginEvent {}

class SetUserNum extends LoginEvent {
  final String userNum;

  const SetUserNum({required this.userNum});
}