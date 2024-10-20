import 'package:chuck2wiz/data/server/request/aiReport/ai_report_request.dart';
import 'package:chuck2wiz/data/server/response/aiReport/ai_report_response.dart';
import 'package:chuck2wiz/data/server/response/aiReport/get_ai_report_response.dart';
import 'package:chuck2wiz/data/server/response/aiReport/get_read_ai_report_response.dart';

import '../../server/vo/aiReport/save_ai_report_vo.dart';

class AiReportRepository {
  Future<AiReportResponse> saveAiReport({required SaveAiReportVo saveAiReportVo}) async {
    return AiReportRequest().saveAiReport(saveAiReportVo: saveAiReportVo);
  }

  Future<GetAiReportResponse> getAiReport({required String userNum}) async {
    return AiReportRequest().getAiReport(userNum: userNum);
  }

  Future<GetReadAiReportResponse> getReadAiReport({required String userNum, required String aiReportId}) {
    return AiReportRequest().getReadAiReport(userNum: userNum, aiReportId: aiReportId);
  }
}
