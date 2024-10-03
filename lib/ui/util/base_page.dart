import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/blocs/main/main_state.dart';

abstract class BasePage<B extends BlocBase<S>, S> extends StatelessWidget {
  const BasePage({super.key});

  // BlocProvider 생성 함수
  B createBloc(BuildContext context);

  // BlocListener에서 사용할 리스너 함수
  void onBlockListener(BuildContext context, S state) {}

  // BlocBuilder에서 사용할 빌더 함수
  Widget buildContent(BuildContext context, S state);

  // 배경 색상 설정
  @protected
  Color get backgroundColor => Colors.white;

  // 상태 표시줄 테마 설정
  @protected
  SystemUiOverlayStyle get systemUiOverlayStyle => SystemUiOverlayStyle.dark;

  /// 하단 네비게이션바 정의
  @protected
  Widget? buildBottomNavigationBar(BuildContext context, int currentIndex) => null;

  /// 선택된 하단 네비게이션 인덱스 가져오기
  @protected
  int getSelectBottomNavIndex(S state) {
    if (state is BottomNavIndex) {
      return state.bottomNavIndex; // 현재 인덱스를 반환
    }
    return 0; // 기본값
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    return BlocProvider<B>(
      create: createBloc,
      child: BlocListener<B, S>(
        listener: onBlockListener,
        child: Scaffold(
          backgroundColor: backgroundColor,
          bottomNavigationBar: BlocBuilder<B, S>(
              builder: (context, state) {
                int currentIndex = getSelectBottomNavIndex(state);

                return buildBottomNavigationBar(context, currentIndex) ?? const SizedBox(height: 0,width: 0,);
              }
          ),
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기
            },
            child: SafeArea(
              child: BlocBuilder<B, S>(
                builder: (context, state) {
                  return buildContent(context, state); // 콘텐츠 빌드
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
