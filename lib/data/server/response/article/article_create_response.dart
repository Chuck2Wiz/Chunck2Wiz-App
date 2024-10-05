import 'dart:convert';

class ArticleCreateResponse {
  bool success;
  String message;
  dynamic data;

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
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data,
  };
}
