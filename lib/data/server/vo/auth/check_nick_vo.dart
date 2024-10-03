import 'package:meta/meta.dart';
import 'dart:convert';

class CheckNickVo {
  final String nick;

  CheckNickVo({
    required this.nick,
  });

  factory CheckNickVo.fromRawJson(String str) => CheckNickVo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckNickVo.fromJson(Map<String, dynamic> json) => CheckNickVo(
    nick: json["nick"],
  );

  Map<String, dynamic> toJson() => {
    "nick": nick,
  };
}
