import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_event.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_state.dart';
import 'package:chuck2wiz/data/db/shared_preferences_helper.dart';
import 'package:chuck2wiz/data/server/vo/ai/chat_vo.dart';
import 'package:chuck2wiz/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AiReportBloc extends Bloc<AiReportEvent, AiReportState> {
  AiReportBloc(): super(AiReportInitial()) {
    on<GetInitData>(_onGetInitData);
    on<AiStreamAnswerData>(_onStreamData);
    on<QuestionEvent>(_onQuestion);

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
      emit(AiReportFailure(error: e));
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
        emit(AiReportFailure(error: 'Error: ${streamedResponse.statusCode}'));
      }
    } catch(e) {
      e.printError();
      emit(AiReportFailure(error: 'Error: $e'));
      emit(state.copyWith(aiAnswer: "Invalid Ai Answered"));
    } finally {
      emit(state.copyWith(isChatLoading: false, isRequest: false, aiAnswer: ""));
    }
  }

  Future<void> _onQuestion(QuestionEvent event, Emitter<AiReportState> emit) async{
    emit(state.copyWith(isQuestion: false));
    print("질문: ${event.question}");
    final chatList = state.chatList;
    chatList?.add(ChatVo(isMy: true, content: event.question));

    emit(state.copyWith(chatList: chatList, isRequest: false, isQuestion: true));
  }

}