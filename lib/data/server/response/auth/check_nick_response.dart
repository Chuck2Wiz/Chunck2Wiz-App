import 'dart:convert';

class CheckNickResponse {
  final bool success;
  final String message;
  final Data data;

  CheckNickResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CheckNickResponse.fromRawJson(String str) => CheckNickResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckNickResponse.fromJson(Map<String, dynamic> json) => CheckNickResponse(
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
  final bool exists;

  Data({
    required this.exists,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    exists: json["exists"],
  );

  Map<String, dynamic> toJson() => {
    "exists": exists,
  };
}
