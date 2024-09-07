import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'kakao_login_event.dart';
import 'kakao_login_state.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class KakaoLoginBloc extends Bloc<KakaoLoginEvent, KakaoLoginState> {
  KakaoLoginBloc() : super(LoginInitial()) {
    on<LoginWithKakao>((event, emit) async {
      emit(LoginLoading());

      // 카카오톡 실행 가능 여부 확인
      // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
      try {
        if (await isKakaoTalkInstalled()) {
          try {
            await UserApi.instance.loginWithKakaoTalk();
            final user = await UserApi.instance.me();
            emit(LoginSuccess(userId: user.id.toString()));
          } catch (error) {
            if (error is PlatformException && error.code == 'CANCELED') {
              emit(LoginFailure(error: '로그인 취소'));
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
      }
    });
  }
}
