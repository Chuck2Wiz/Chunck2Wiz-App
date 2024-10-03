import 'package:meta/meta.dart';
import 'dart:convert';

class SignUpResponse {
  final bool success;
  final String message;
  final Data data;

  SignUpResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SignUpResponse.fromRawJson(String str) => SignUpResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
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
  final String token;

  Data({
    required this.token,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
