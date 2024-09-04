import 'package:equatable/equatable.dart';

abstract class KakaoLoginState extends Equatable {
  const KakaoLoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends KakaoLoginState {}

class LoginLoading extends KakaoLoginState {}

class LoginSuccess extends KakaoLoginState {
  final String userId;

  const LoginSuccess({required this.userId});

  @override
  List<Object> get props => [userId];
}

class LoginFailure extends KakaoLoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
