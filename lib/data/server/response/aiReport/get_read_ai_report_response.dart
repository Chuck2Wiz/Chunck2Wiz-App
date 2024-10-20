import 'package:meta/meta.dart';
import 'dart:convert';

class GetReadAiReportResponse {
  bool success;
  String message;
  GetReadAiReportResponseData data;

  GetReadAiReportResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetReadAiReportResponse.fromRawJson(String str) => GetReadAiReportResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetReadAiReportResponse.fromJson(Map<String, dynamic> json) => GetReadAiReportResponse(
    success: json["success"],
    message: json["message"],
    data: GetReadAiReportResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class GetReadAiReportResponseData {
  AiReport aiReport;

  GetReadAiReportResponseData({
    required this.aiReport,
  });

  factory GetReadAiReportResponseData.fromRawJson(String str) => GetReadAiReportResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetReadAiReportResponseData.fromJson(Map<String, dynamic> json) => GetReadAiReportResponseData(
    aiReport: AiReport.fromJson(json["aiReport"]),
  );

  Map<String, dynamic> toJson() => {
    "aiReport": aiReport.toJson(),
  };
}

class AiReport {
  AiReportData data;
  String id;

  AiReport({
    required this.data,
    required this.id,
  });

  factory AiReport.fromRawJson(String str) => AiReport.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AiReport.fromJson(Map<String, dynamic> json) => AiReport(
    data: AiReportData.fromJson(json["data"]),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "_id": id,
  };
}

class AiReportData {
  String selectOption;
  List<String> formData;
  List<String> answerData;
  String reportValue;

  AiReportData({
    required this.selectOption,
    required this.formData,
    required this.answerData,
    required this.reportValue,
  });

  factory AiReportData.fromRawJson(String str) => AiReportData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AiReportData.fromJson(Map<String, dynamic> json) => AiReportData(
    selectOption: json["selectOption"],
    formData: List<String>.from(json["formData"].map((x) => x)),
    answerData: List<String>.from(json["answerData"].map((x) => x)),
    reportValue: json["reportValue"],
  );

  Map<String, dynamic> toJson() => {
    "selectOption": selectOption,
    "formData": List<dynamic>.from(formData.map((x) => x)),
    "answerData": List<dynamic>.from(answerData.map((x) => x)),
    "reportValue": reportValue,
  };
}
