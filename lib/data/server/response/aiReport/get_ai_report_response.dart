import 'package:meta/meta.dart';
import 'dart:convert';

class GetAiReportResponse {
  bool success;
  String message;
  GetAiReportResponseData data;

  GetAiReportResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetAiReportResponse.fromRawJson(String str) => GetAiReportResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAiReportResponse.fromJson(Map<String, dynamic> json) => GetAiReportResponse(
    success: json["success"],
    message: json["message"],
    data: GetAiReportResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class GetAiReportResponseData {
  List<AiReport> aiReports;

  GetAiReportResponseData({
    required this.aiReports,
  });

  factory GetAiReportResponseData.fromRawJson(String str) => GetAiReportResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAiReportResponseData.fromJson(Map<String, dynamic> json) => GetAiReportResponseData(
    aiReports: List<AiReport>.from(json["aiReports"].map((x) => AiReport.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "aiReports": List<dynamic>.from(aiReports.map((x) => x.toJson())),
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
