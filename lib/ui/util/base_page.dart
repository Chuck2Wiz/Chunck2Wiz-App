import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    return BlocProvider<B>(
      create: createBloc,
      child: BlocListener<B, S>(
        listener: onBlockListener,
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: BlocBuilder<B, S>(
              builder: (context, state) {
                return buildContent(context, state);
              },
            ),
          ),
        ),
      ),
    );
  }
}
