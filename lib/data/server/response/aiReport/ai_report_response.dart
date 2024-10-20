import 'package:meta/meta.dart';
import 'dart:convert';

class AiReportResponse {
  bool success;
  String message;
  Data data;

  AiReportResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AiReportResponse.fromRawJson(String str) => AiReportResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AiReportResponse.fromJson(Map<String, dynamic> json) => AiReportResponse(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data();

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
