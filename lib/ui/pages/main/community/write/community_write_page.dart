import 'package:chuck2wiz/data/blocs/main/community/community_state.dart';
import 'package:chuck2wiz/data/blocs/main/community/write/community_write_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/community/write/community_write_event.dart';
import 'package:chuck2wiz/data/blocs/main/community/write/community_write_state.dart';
import 'package:chuck2wiz/ui/define/color_defines.dart';
import 'package:chuck2wiz/ui/define/font_defines.dart';
import 'package:chuck2wiz/ui/pages/login_page.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:chuck2wiz/ui/widget/textField/base_text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../../../../../data/blocs/main/community/community_bloc.dart';
import '../../../../../data/blocs/main/community/community_event.dart';

class CommunityWritePage
    extends BasePage<CommunityWriteBloc, CommunityWriteState> {
  const CommunityWritePage({super.key}): super(keepBlocAlive: true);

  @override
  CommunityWriteBloc createBloc(BuildContext context) {
    return context.read<CommunityWriteBloc>();
  }

  @override
  void onBlockListener(BuildContext context, CommunityWriteState state) {
    if(state is CommunityWriteSuccess) {
      context.read<CommunityBloc>().add(RefreshArticle());
      Get.back();
    }
  }

  @override
  Widget buildContent(BuildContext context, CommunityWriteState state) {
    return Stack(
      children: [
        Column(
          children: [
            _writeTitleWidget(
              state: state,
              onClickBackButton: () {
                Get.back();
              },
              onClickWriteButton: state.isValid
                  ? () => context.read<CommunityWriteBloc>().add(
                  CompleteWrite(content: state.content, title: state.title))
                  : null,
            ),
            Expanded(
              child: Column(
                children: [
                  _titleTextFieldWidget(
                      onChange: (value) {
                        context.read<CommunityWriteBloc>().add(
                            WriteTitle(value)
                        );
                      }),
                  _lineWidget(),
                  Expanded(child: _contentTextFieldWidget(
                      onChange: (value) {
                        context.read<CommunityWriteBloc>().add(
                            WriteContent(value)
                        );
                      })
                  ),
                ],
              ),
            ),
          ],
        ),
        Visibility(
            visible: state.isLoading, child: _circularLoading())
      ],
    );
  }

  Widget _circularLoading() {
    return const Center(
        child: CircularProgressIndicator(
      color: ColorDefines.mainColor,
    ));
  }

  Widget _writeTitleWidget(
      {required CommunityWriteState state,
      required Function() onClickBackButton,
      required Function()? onClickWriteButton}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 24,
            ),
            onPressed: onClickBackButton),
        Text(
          "글쓰기",
          style: FontDefines.black18Bold,
        ),
        TextButton(
          onPressed: onClickWriteButton,
          child: Text(
            "등록",
            style: state.isValid
                ? FontDefines.main15Normal
                : FontDefines.deactiviate15,
          ),
        ),
      ],
    );
  }

  Widget _titleTextFieldWidget({
    required Function(String) onChange,
  }) {
    return BaseTextFieldWidget(
        hint: "제목",
        textStyle: FontDefines.normal15, onChange: onChange);
  }

  Widget _lineWidget() {
    return Container(
      width: double.infinity,
      height: 0.5,
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: ColorDefines.primaryGray,
    );
  }

  Widget _contentTextFieldWidget({
    required Function(String) onChange,
  }) {
    return BaseTextFieldWidget(
        hint: "내용",
        textStyle: FontDefines.normal15, onChange: onChange);
  }
}
