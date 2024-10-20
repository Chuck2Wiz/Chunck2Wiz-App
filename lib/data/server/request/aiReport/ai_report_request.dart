import 'dart:convert';

import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_bloc.dart';
import 'package:chuck2wiz/data/http/base_http.dart';
import 'package:chuck2wiz/data/server/response/aiReport/ai_report_response.dart';
import 'package:chuck2wiz/data/server/response/aiReport/get_ai_report_response.dart';
import 'package:chuck2wiz/data/server/response/aiReport/get_read_ai_report_response.dart';
import 'package:chuck2wiz/data/server/vo/aiReport/save_ai_report_vo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class AiReportRequest {
  static String BASE_URL = "${dotenv.env['API_URL']}/v1/aiReports";
  /**
   * POST
   */
  Future<AiReportResponse> saveAiReport({required SaveAiReportVo saveAiReportVo}) async {
    final url = Uri.parse(BASE_URL);

    try {
      final response = await BaseHttp().post(
          url.toString(),
          saveAiReportVo
      );

      return AiReportResponse.fromJson(jsonDecode(response));
    } catch(e) {
      e.printError();
      rethrow;
    }
  }

  /**
   * GET /:userNum
   */
  Future<GetAiReportResponse> getAiReport({required String userNum}) async {
    final url = Uri.parse('$BASE_URL/$userNum');

    try {
      final response = await BaseHttp().get(url.toString());

      return GetAiReportResponse.fromJson(jsonDecode(response));
    } catch(e) {
      e.printError;
      rethrow;
    }
  }


  /**
   * GET /:userNum/:aiReportId
   */
  Future<GetReadAiReportResponse> getReadAiReport({required String userNum, required String aiReportId}) async {
    final url = Uri.parse('$BASE_URL/$userNum/$aiReportId');

    try {
      final response = await BaseHttp().get(url.toString());

      return GetReadAiReportResponse.fromJson(jsonDecode(response));
    } catch(e) {
      e.printError;
      rethrow;
    }
  }

}