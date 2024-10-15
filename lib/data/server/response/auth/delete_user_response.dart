import 'package:meta/meta.dart';
import 'dart:convert';

class DeleteUserResponse {
  bool success;
  String message;
  Data data;

  DeleteUserResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DeleteUserResponse.fromRawJson(String str) => DeleteUserResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteUserResponse.fromJson(Map<String, dynamic> json) => DeleteUserResponse(
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
