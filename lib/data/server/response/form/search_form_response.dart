import 'package:meta/meta.dart';
import 'dart:convert';

class SearchFormResponse {
  bool success;
  String message;
  List<FormData> data;

  SearchFormResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SearchFormResponse.fromRawJson(String str) => SearchFormResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchFormResponse.fromJson(Map<String, dynamic> json) => SearchFormResponse(
    success: json["success"],
    message: json["message"],
    data: List<FormData>.from(json["data"].map((x) => FormData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FormData {
  String id;
  String option;
  List<String> questions;

  FormData({
    required this.id,
    required this.option,
    required this.questions,
  });

  factory FormData.fromRawJson(String str) => FormData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FormData.fromJson(Map<String, dynamic> json) => FormData(
    id: json["_id"],
    option: json["option"],
    questions: List<String>.from(json["questions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "option": option,
    "questions": List<dynamic>.from(questions.map((x) => x)),
  };
}
