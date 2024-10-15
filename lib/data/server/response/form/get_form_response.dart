import 'package:meta/meta.dart';
import 'dart:convert';

class GetFormResponse {
  bool success;
  String message;
  Data data;

  GetFormResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetFormResponse.fromRawJson(String str) => GetFormResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetFormResponse.fromJson(Map<String, dynamic> json) => GetFormResponse(
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
  List<ResponseForm> responseForms;

  Data({
    required this.responseForms,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    responseForms: List<ResponseForm>.from(json["responseForms"].map((x) => ResponseForm.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseForms": List<dynamic>.from(responseForms.map((x) => x.toJson())),
  };
}

class ResponseForm {
  String option;

  ResponseForm({
    required this.option,
  });

  factory ResponseForm.fromRawJson(String str) => ResponseForm.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseForm.fromJson(Map<String, dynamic> json) => ResponseForm(
    option: json["option"],
  );

  Map<String, dynamic> toJson() => {
    "option": option,
  };
}
