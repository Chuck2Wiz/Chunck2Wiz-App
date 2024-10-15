import 'package:meta/meta.dart';
import 'dart:convert';

class ArticleCreateResponse {
  bool success;
  String message;
  Data data;

  ArticleCreateResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ArticleCreateResponse.fromRawJson(String str) => ArticleCreateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleCreateResponse.fromJson(Map<String, dynamic> json) => ArticleCreateResponse(
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
