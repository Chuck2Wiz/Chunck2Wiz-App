import 'package:equatable/equatable.dart';

abstract class KakaoLoginEvent extends Equatable {
  const KakaoLoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithKakao extends KakaoLoginEvent {
  const LoginWithKakao();
}
