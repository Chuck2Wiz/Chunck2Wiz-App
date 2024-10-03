import 'package:meta/meta.dart';
import 'dart:convert';

class CheckUserResponse {
  final bool success;
  final String message;
  final Data data;

  CheckUserResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CheckUserResponse.fromRawJson(String str) => CheckUserResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckUserResponse.fromJson(Map<String, dynamic> json) => CheckUserResponse(
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
  final Response response;

  Data({
    required this.response,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
  };
}

class Response {
  final bool exists;
  final dynamic token;

  Response({
    required this.exists,
    required this.token,
  });

  factory Response.fromRawJson(String str) => Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    exists: json["exists"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "exists": exists,
    "token": token,
  };
}
