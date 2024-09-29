import 'dart:convert';

BaseResponse baseResponseFromJson(String str) => BaseResponse.fromJson(json.decode(str));

String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());

class BaseResponse {
  bool success;
  dynamic message;

  BaseResponse({
    required this.success,
    required this.message,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
