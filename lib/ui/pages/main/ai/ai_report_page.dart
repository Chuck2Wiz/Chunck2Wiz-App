import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_event.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_state.dart';
import 'package:chuck2wiz/data/server/vo/ai/chat_vo.dart';
import 'package:chuck2wiz/ui/define/format_defines.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:chuck2wiz/ui/widget/animtation/ai_loading_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../define/color_defines.dart';
import '../../../widget/textField/base_text_field_widget.dart';

class AiReportPage extends BasePage<AiReportBloc, AiReportState> {
  late List<ChatVo> chatList;
  TextEditingController textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  AiReportPage({super.key});

  @override
  AiReportBloc createBloc(BuildContext context) {
    return context.read<AiReportBloc>();
  }

  @override
  void onInit(BuildContext context, AiReportBloc bloc) {
    final answerData = bloc.state.answerData;
    final formData = bloc.state.formData![0].questions;

    String initQuestion =
        "${FormatDefines.formOptionFormat(option: bloc.state.selectOption ?? "")}에 대해 제 상황에 맞는 답변을 부탁드립니다.";
    if (!bloc.isClosed) {
      for (var i = 0; i < answerData!.length; i++) {
        initQuestion += "${formData[0]}: ${answerData[0]}";
      }

      bloc.add(AiStreamAnswerData(question: initQuestion));
    }
  }

  @override
  Widget buildContent(BuildContext context, AiReportState state) {
    if (state.isQuestion) {
      textEditingController.clear();
    }
    return Column(
      children: [
        /// Title
        _aiReportTitleWidget(onClickBack: () {
          Navigator.pop(context);
        }),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                /// Chat List
                Flexible(
                  child: Visibility(
                    visible: (state.chatList != null && !state.isRequest) ||
                        state.isQuestion,
                    child: _chatBubbleWidget(state: state),
                  ),
                ),

                /// Streaming 형태로 오는 Chat (응답이 끝나면 사라진다)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Stack(
                    children: [
                      Visibility(
                        visible: state.isChatLoading && state.isRequest,
                        child: _chatBubble(
                            textWidget: AiLoadingTextWidget(
                              selectOptions: FormatDefines.formOptionFormat(
                                option: state.selectOption ?? "",
                              ),
                            ),
                            isMy: false,
                            isFirst: false),
                      ),
                      Visibility(
                        visible: !state.isChatLoading && state.isRequest,
                        child: _chatBubble(
                          textWidget: Text(
                            state.aiAnswer,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          isMy: false,
                          isFirst: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        /// 질문 버튼
        Align(
          alignment: Alignment.bottomCenter,
          child: _sendQuestionWidget(
              state: state,
              onChange: (value) {
                textEditingController.text = value;
              },
              onClickSend: () {
                if (textEditingController.text.isNotEmpty) {
                  context
                      .read<AiReportBloc>()
                      .add(QuestionEvent(question: textEditingController.text));
                  Future.delayed(Duration(milliseconds: 100), () {
                    _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent);
                  });
                }
              },
            onClickBox: () {
              if(!state.isRequest) {
                Future.delayed(Duration(milliseconds: 100), () {
                  _scrollController
                      .jumpTo(_scrollController.position.maxScrollExtent);
                });
              }
            }
          ),
        )
      ],
    );
  }

  Widget _aiReportTitleWidget({required Function() onClickBack}) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: IconButton(
                onPressed: onClickBack,
                icon: const Icon(Icons.arrow_back_ios, size: 24)),
          ),
          Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                child: const Text(
                  "분석 결과",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ))
        ],
      ),
    );
  }

  Widget _sendQuestionWidget(
      {required Function(String) onChange,
      required Function() onClickSend,
      required AiReportState state,
      required Function() onClickBox}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 0),
                blurRadius: 7,
                spreadRadius: 3)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: BaseTextFieldWidget(
            onTap: onClickBox,
            readOnly: state.isRequest,
            onChange: onChange,
            textEditingController: textEditingController,
            initialText: "",
            hint: state.isRequest ? "분석 중..." : "추가적으로 질문하기",
            hintTextStyle:
                TextStyle(color: ColorDefines.primaryGray, fontSize: 14),
          )),
          IconButton(
            icon: Icon(
              const IconData(0xf574, fontFamily: 'MaterialIcons'),
              color: state.isRequest
                  ? ColorDefines.primaryGray
                  : ColorDefines.mainColor,
              size: 28,
            ),
            onPressed: state.isRequest ? null : onClickSend,
          )
        ],
      ),
    );
  }

  Widget _chatBubbleWidget({required AiReportState state}) {
    if (state.chatList == null) {
      return Container();
    }

    return ListView.builder(
      itemCount: state.chatList!.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        final TextStyle textStyle = state.chatList![index].isMy
            ? TextStyle(color: Colors.white, fontSize: 16)
            : TextStyle(color: Colors.black, fontSize: 16);

        return Align(
            alignment: state.chatList![index].isMy
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: _chatBubble(
                textWidget: Text(
                  state.chatList![index].content,
                  style: textStyle,
                ),
                isMy: state.chatList![index].isMy,
                isFirst: index == 0));
      },
    );
  }

  Widget _chatBubble({
    required Widget textWidget,
    required bool isMy,
    required bool isFirst,
  }) {
    final Color chatBackgroundColor =
        isMy ? ColorDefines.mainColor : ColorDefines.primaryWhite;

    return Container(
      margin: isMy
          ? const EdgeInsets.fromLTRB(20, 0, 10, 10)
          : const EdgeInsets.fromLTRB(10, 0, 20, 10),
      padding: isMy
          ? const EdgeInsets.fromLTRB(20, 15, 20, 15)
          : const EdgeInsets.fromLTRB(20, 15, 30, 15),
      decoration: BoxDecoration(
          color: chatBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isMy
              ? null
              : [
                  BoxShadow(
                      color: ColorDefines.mainColor.withOpacity(0.3),
                      offset: Offset(0, 0),
                      blurRadius: 7,
                      spreadRadius: 3)
                ]),
      child: Column(
        children: [
          textWidget,
          if (isFirst)
            GestureDetector(
              onTap: () {},
              child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: ColorDefines.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "리포트 저장하기",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            )
        ],
      ),
    );
  }
}
