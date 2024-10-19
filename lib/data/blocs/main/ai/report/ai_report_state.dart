import 'package:chuck2wiz/data/server/vo/ai/chat_vo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../server/response/form/search_form_response.dart';

class AiReportState extends Equatable {
  final bool? isLoading;
  final String? selectOption;
  final List<FormData>? formData;
  final List<String>? answerData;
  final List<ChatVo>? chatList;
  final String aiAnswer;
  final bool isChatLoading;
  final bool isRequest;
  final bool isQuestion;

  const AiReportState({
    this.isLoading = false,
    this.selectOption,
    this.formData,
    this.answerData,
    this.chatList,
    this.aiAnswer = "",
    this.isChatLoading = false,
    this.isRequest = false,
    this.isQuestion = false
  });

  AiReportState copyWith({
    bool? isLoading,
    String? selectOption,
    List<FormData>? formData,
    List<String>? answerData,
    List<ChatVo>? chatList,
    String? aiAnswer = "",
    bool? isChatLoading,
    bool? isRequest,
    bool? isQuestion
  }) {
    String newAiAnswer = this.aiAnswer + (aiAnswer ?? "");
    List<ChatVo> updatedChatList = List.from(chatList ?? this.chatList ?? []);

    return AiReportState(
      isLoading: isLoading ?? this.isLoading,
      selectOption: selectOption ?? this.selectOption,
      formData: formData ?? this.formData,
      chatList: updatedChatList,
      answerData: answerData ?? this.answerData,
      aiAnswer: (isChatLoading == false && isRequest == false) ? "" : newAiAnswer,
      isChatLoading: isChatLoading ?? this.isChatLoading,
      isRequest: isRequest ?? this.isRequest,
      isQuestion: isQuestion ?? this.isQuestion
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    selectOption,
    formData,
    answerData,
    aiAnswer,
    isChatLoading,
    List.from(chatList ?? []),
    isRequest,
    isQuestion
  ];
}

class AiReportInitial extends AiReportState {}

class AiReportFailure extends AiReportState {
  final dynamic error;

  const AiReportFailure({required this.error});
}