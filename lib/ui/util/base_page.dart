import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/blocs/main/main_state.dart';

abstract class BasePage<B extends BlocBase<S>, S> extends StatelessWidget {
  final bool keepBlocAlive;

  const BasePage({super.key, this.keepBlocAlive = false});

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

  /// 초기화를 위한 메서드
  @protected
  void onInit(BuildContext context, B bloc) {}

  @protected
  bool get isSafeArea => true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: BlocProvider<B>(
        create: (context) {
          if (!keepBlocAlive) {
            onInit(context, createBloc(context));
            return createBloc(context);
          } else {
            onInit(context, context.read<B>());
            return context.read<B>();
          }
        },
        child: BlocListener<B, S>(
          listener: (context, state) {
            onBlockListener(context, state); // 상태 변화에 따른 로직 처리
          },
          child: isSafeArea ? SafeArea(
              child: Scaffold(
                appBar: null,
                backgroundColor: backgroundColor,
                extendBodyBehindAppBar: false,
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
              )
          ) : _rootScaffoldWidget()
        ),
      ),
    );
  }


  /// 상단 앱 바 정의
  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  Widget _rootScaffoldWidget() {
    return Scaffold(
      appBar: null,
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: false,
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
    );
  }
}
