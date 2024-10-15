import 'package:equatable/equatable.dart';

class LoginState extends Equatable{
  final bool isLoading;

  const LoginState({this.isLoading = false});

  @override
  List<Object> get props => [];

  LoginState copyWith({bool? isLoading}) {
    return LoginState(isLoading: isLoading ?? this.isLoading);
  }
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final bool isInitUser;

  const LoginSuccess({required this.isInitUser});

  @override
  List<Object> get props => [
    isInitUser
  ];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [
    error
  ];
}