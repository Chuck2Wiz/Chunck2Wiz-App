import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/login/login_event.dart';
import 'package:chuck2wiz/data/blocs/login/login_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginWithNaver>(_onLoginNaver);
    on<LoginWithKakao>(_onLoginKakao);
  }

  Future<void> _onLoginNaver(LoginWithNaver event, Emitter<LoginState> emit) async {
    emit(LoginInitial());
    try {
      final NaverLoginResult res = await FlutterNaverLogin.logIn();
      emit(LoginSuccess(userId: res.account.id));
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    } finally {
      emit(LoginInitial());
    }
  }

  Future<void> _onLoginKakao(LoginWithKakao event, Emitter<LoginState> emit) async {
    emit(LoginInitial());
    try {
      if (await isKakaoTalkInstalled()) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          final user = await UserApi.instance.me();
          emit(LoginSuccess(userId: user.id.toString()));
        } catch (error) {
          if (error is PlatformException && error.code == 'CANCELED') {
            emit(const LoginFailure(error: '로그인 취소'));
            return;
          }
          try {
            await UserApi.instance.loginWithKakaoAccount();
            final user = await UserApi.instance.me();
            emit(LoginSuccess(userId: user.id.toString()));
          } catch (error) {
            emit(LoginFailure(error: '카카오계정으로 로그인 실패: $error'));
          }
        }
      } else {
        try {
          await UserApi.instance.loginWithKakaoAccount();
          final user = await UserApi.instance.me();
          emit(LoginSuccess(userId: user.id.toString()));
        } catch (error) {
          emit(LoginFailure(error: '카카오계정으로 로그인 실패: $error'));
        }
      }
    } catch (error) {
      emit(LoginFailure(error: '카카오톡 설치 여부 확인 실패: $error'));
    } finally {
      emit(LoginInitial());
    }
  }
}