import 'package:meta/meta.dart';
import 'dart:convert';

class CheckUserVo {
  final String userNum;

  CheckUserVo({
    required this.userNum,
  });

  factory CheckUserVo.fromRawJson(String str) => CheckUserVo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckUserVo.fromJson(Map<String, dynamic> json) => CheckUserVo(
    userNum: json["userNum"],
  );

  Map<String, dynamic> toJson() => {
    "userNum": userNum,
  };
}
