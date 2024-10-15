import 'package:meta/meta.dart';
import 'dart:convert';

class GetUserInfoResponse {
  bool success;
  String message;
  Data data;

  GetUserInfoResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetUserInfoResponse.fromRawJson(String str) => GetUserInfoResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetUserInfoResponse.fromJson(Map<String, dynamic> json) => GetUserInfoResponse(
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
  String id;
  String userNum;
  String nick;
  int age;
  String gender;
  String job;
  List<String> favorite;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Data({
    required this.id,
    required this.userNum,
    required this.nick,
    required this.age,
    required this.gender,
    required this.job,
    required this.favorite,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    userNum: json["userNum"],
    nick: json["nick"],
    age: json["age"],
    gender: json["gender"],
    job: json["job"],
    favorite: List<String>.from(json["favorite"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userNum": userNum,
    "nick": nick,
    "age": age,
    "gender": gender,
    "job": job,
    "favorite": List<dynamic>.from(favorite.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
