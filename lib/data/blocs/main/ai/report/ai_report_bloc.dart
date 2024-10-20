import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/form/ai_form_state.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_event.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_state.dart';
import 'package:chuck2wiz/data/db/shared_preferences_helper.dart';
import 'package:chuck2wiz/data/repository/aiReport/ai_report_repository.dart';
import 'package:chuck2wiz/data/server/vo/ai/chat_vo.dart';
import 'package:chuck2wiz/data/server/vo/aiReport/save_ai_report_vo.dart';
import 'package:chuck2wiz/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AiReportBloc extends Bloc<AiReportEvent, AiReportState> {
  final AiReportRepository aiReportRepository;

  AiReportBloc(this.aiReportRepository): super(AiReportInitial()) {
    on<GetInitData>(_onGetInitData);
    on<AiStreamAnswerData>(_onStreamData);
    on<QuestionEvent>(_onQuestion);
    on<SaveAiReportEvent>(_onSaveAiReport);
  }

  Future<void> _onGetInitData(GetInitData event, Emitter<AiReportState> emit) async{
    emit(state.copyWith(isLoading: true));

    try {
      final answerData = await SharedPreferencesHelper.getAnswerData();

      emit(state.copyWith(
          selectOption: event.selectOption,
          formData: event.formData,
          answerData: answerData));
    } catch(e) {
      emit(AiReportFailure(error: e, previousState: state));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
  
  Future<void> _onStreamData(AiStreamAnswerData event, Emitter<AiReportState> emit) async {
    emit(state.copyWith(isChatLoading: true, isRequest: true));
    try {
      final url = dotenv.env['CHAT_API_URL'] ?? "";
      final parseURI = Uri.parse(url);
      final request = http.Request(
          'Post',
          parseURI
      );
      request.headers['Content-Type'] = 'application/json';
      request.body = json.encode({
        "content": event.question,
      });

      final streamedResponse = await request.send();

      if(streamedResponse.statusCode == 200) {
        final response = http.StreamedResponse(
            streamedResponse.stream, 
            streamedResponse.statusCode
        );
        StringBuffer buffer = StringBuffer();
        
        await for(var data in response.stream.transform(utf8.decoder)) {
          if(state.isChatLoading == true) {
            emit(state.copyWith(isChatLoading: false));
          }
          buffer.write(data);
          emit(state.copyWith(aiAnswer: data));
        }

        List<ChatVo> updatedChatList = List.from(state.chatList ?? []);
        updatedChatList.add(ChatVo(isMy: false, content: state.aiAnswer));

        emit(state.copyWith(chatList: updatedChatList));
      }else {
        emit(AiReportFailure(error: 'Error: ${streamedResponse.statusCode}', previousState: state));
      }
    } catch(e) {
      e.printError();
      emit(AiReportFailure(error: 'Error: $e', previousState: state));
      emit(state.copyWith(aiAnswer: "Invalid Ai Answered"));
    } finally {
      emit(state.copyWith(isChatLoading: false, isRequest: false, aiAnswer: ""));
    }
  }

  Future<void> _onQuestion(QuestionEvent event, Emitter<AiReportState> emit) async{
    emit(state.copyWith(isQuestion: false));

    final chatList = state.chatList;
    chatList?.add(ChatVo(isMy: true, content: event.question));

    emit(state.copyWith(chatList: chatList, isRequest: false, isQuestion: true));
  }

  Future<void> _onSaveAiReport(SaveAiReportEvent event, Emitter<AiReportState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final userNum = await SharedPreferencesHelper.getUserNum();
      final selectOption = state.selectOption;
      final formData = state.formData?[0].questions;
      final answerData = state.answerData;

      if(userNum == null || selectOption == null || formData == null || answerData == null) {
        throw Exception("Data is NULL");
      }

      final response = await aiReportRepository.saveAiReport(
          saveAiReportVo: SaveAiReportVo(
              userNum: userNum,
              selectOption: selectOption,
              formData: formData,
              answerData: answerData,
              reportValue: event.aiAnswer.isNotEmpty ? event.aiAnswer : "Default Answer"
          )
      );

      if(response.success) {
        emit(SaveAiReportSuccess(previousState: state));
        emit(state.copyWith(isSaveReport: true));
      } else {
        emit(SaveAiReportFailure(error: response.message, previousState: state));
      }
    }catch(e) {
      debugPrint('Error occurred while saving AI report: $e');
      emit(SaveAiReportFailure(error: 'Error: $e', previousState: state));
    }finally {
      emit(state.copyWith(isLoading: false));
    }
  }

}