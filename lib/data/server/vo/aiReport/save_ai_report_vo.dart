import 'package:meta/meta.dart';
import 'dart:convert';

class SaveAiReportVo {
  String userNum;
  String selectOption;
  List<String> formData;
  List<String> answerData;
  String reportValue;

  SaveAiReportVo({
    required this.userNum,
    required this.selectOption,
    required this.formData,
    required this.answerData,
    required this.reportValue,
  });

  factory SaveAiReportVo.fromRawJson(String str) => SaveAiReportVo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaveAiReportVo.fromJson(Map<String, dynamic> json) => SaveAiReportVo(
    userNum: json["userNum"],
    selectOption: json["selectOption"],
    formData: List<String>.from(json["formData"].map((x) => x)),
    answerData: List<String>.from(json["answerData"].map((x) => x)),
    reportValue: json["reportValue"],
  );

  Map<String, dynamic> toJson() => {
    "userNum": userNum,
    "selectOption": selectOption,
    "formData": List<dynamic>.from(formData.map((x) => x)),
    "answerData": List<dynamic>.from(answerData.map((x) => x)),
    "reportValue": reportValue,
  };
}
