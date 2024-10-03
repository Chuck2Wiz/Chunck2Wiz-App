import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/login/login_event.dart';
import 'package:chuck2wiz/data/blocs/login/login_state.dart';
import 'package:chuck2wiz/data/db/shared_preferences_helper.dart';
import 'package:chuck2wiz/data/repository/login_repository.dart';
import 'package:chuck2wiz/data/server/request/auth/auth_request.dart';
import 'package:chuck2wiz/data/server/vo/auth/check_user_vo.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc(this._loginRepository) : super(LoginInitial()) {
    on<LoginWithNaver>(_onLoginNaver);
    on<LoginWithKakao>(_onLoginKakao);
  }

  Future<void> _onLoginNaver(LoginWithNaver event, Emitter<LoginState> emit) async {
    emit(LoginInitial());
    try {
      final NaverLoginResult res = await FlutterNaverLogin.logIn();
      await SharedPreferencesHelper.saveUserNum(res.account.id);

      final bool isExistUser = await checkExistUser(userNum: res.account.id);
      print("naver login: $isExistUser");

      emit(LoginSuccess(isInitUser: !isExistUser));
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

          await SharedPreferencesHelper.saveUserNum(user.id.toString());

          final bool isExistUser = await checkExistUser(userNum: user.id.toString());

          emit(LoginSuccess(isInitUser: !isExistUser));
        } catch (error) {
          if (error is PlatformException && error.code == 'CANCELED') {
            emit(const LoginFailure(error: '로그인 취소'));
            return;
          }
          try {
            await UserApi.instance.loginWithKakaoAccount();
            final user = await UserApi.instance.me();

            final bool isExistUser = await checkExistUser(userNum: user.id.toString());

            emit(LoginSuccess(isInitUser: !isExistUser));
          } catch (error) {
            emit(LoginFailure(error: '카카오계정으로 로그인 실패: $error'));
          }
        }
      } else {
        try {
          await UserApi.instance.loginWithKakaoAccount();
          final user = await UserApi.instance.me();

          final bool isExistUser = await checkExistUser(userNum: user.id.toString());

          emit(LoginSuccess(isInitUser: !isExistUser));
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

  Future<bool> checkExistUser({required String userNum}) async {
    print("checkExistUser: $userNum");
    final response = await AuthRequest().checkUser(CheckUserVo(userNum: userNum));

    print("checkExistUser: ${response}");
    if (response.success) {
      return response.data.response.exists;
    } else {
      return false;
    }
  }
}