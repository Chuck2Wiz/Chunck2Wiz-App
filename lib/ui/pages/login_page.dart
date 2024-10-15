import 'dart:ui';

import 'package:chuck2wiz/data/blocs/login/plat_form.dart';
import 'package:chuck2wiz/data/repository/auth/login_repository.dart';
import 'package:chuck2wiz/ui/define/color_defines.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:chuck2wiz/ui/widget/sns_login_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../data/blocs/login/login_bloc.dart';
import '../../data/blocs/login/login_event.dart';
import '../../data/blocs/login/login_state.dart';

class LoginPage extends BasePage<LoginBloc, LoginState> {
  const LoginPage({super.key});

  @override
  LoginBloc createBloc(BuildContext context) {
    return LoginBloc(LoginRepository());
  }

  @override
  bool get isSafeArea => false;

  @override
  void onBlockListener(BuildContext context, LoginState state) {
    if (state is LoginSuccess) {
      if(state.isInitUser) {
        Get.toNamed('/signUp');
      } else {
        Get.toNamed('/main');
      }
    }
  }

  @override
  Color get backgroundColor => ColorDefines.mainColor;

  @override
  SystemUiOverlayStyle get systemUiOverlayStyle => SystemUiOverlayStyle.light;

  @override
  Widget buildContent(BuildContext context, LoginState state) {
    return Stack(
      children: [
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 24),
                  child: appTitleText(),
                ),
                const SizedBox(height: 48),
                loginBannerImage(),
                const SizedBox(height: 24),
                snsLoginButtons(
                        () => onClickNaverLogin(context),
                        () => onClickKakaoLogin(context)
                ),
              ],
            ),
          ),
        ),
        _circularLoading(state: state)
      ],
    );
  }

  Widget _circularLoading({required LoginState state}) {
    return Visibility(
        visible: state.isLoading,
        child: const Center(child: CircularProgressIndicator(color: ColorDefines.mainColor,),)
    );
  }

  void onClickNaverLogin(BuildContext context) {
    context.read<LoginBloc>().add(LoginWithNaver());
  }

  void onClickKakaoLogin(BuildContext context) {
    context.read<LoginBloc>().add(LoginWithKakao());
  }

  Widget appTitleText() {
    return SizedBox(
        width: double.infinity,
        child: RichText(
          text: const TextSpan(children: [
            TextSpan(
                text: "AI 법률 서비스\n",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorDefines.primaryWhite,
                    fontSize: 22,
                    height: 1.15)),
            TextSpan(
                text: "척척법사",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorDefines.primaryWhite,
                  fontSize: 66,
                )),
          ]),
        ));
  }

  Widget loginBannerImage() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        alignment: Alignment.centerRight,
        child: Image.asset('assets/images/ic_login_banner.png'),
      ),
    );
  }

  Widget snsLoginButtons(VoidCallback onClickNaverLogin, VoidCallback onClickKakaoLogin) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "지금 시작해보세요",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          SnsLoginButtonWidget(
              platForm: PlatForm.naver,
              onClickLogin: onClickNaverLogin
          ),
          const SizedBox(height: 12),
          SnsLoginButtonWidget(
              platForm: PlatForm.kakao,
              onClickLogin: onClickKakaoLogin
          )
        ],
      ),
    );
  }
}
