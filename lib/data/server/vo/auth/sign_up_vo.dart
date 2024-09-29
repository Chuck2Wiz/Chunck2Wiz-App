import 'dart:convert';

class SignUpVo {
  final String userNum;
  final String nick;
  final int age;
  final String gender;
  final String job;
  final List<String> favorite;

  SignUpVo({
    required this.userNum,
    required this.nick,
    required this.age,
    required this.gender,
    required this.job,
    required this.favorite,
  });

  factory SignUpVo.fromRawJson(String str) => SignUpVo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignUpVo.fromJson(Map<String, dynamic> json) => SignUpVo(
    userNum: json["userNum"],
    nick: json["nick"],
    age: json["age"],
    gender: json["gender"],
    job: json["job"],
    favorite: List<String>.from(json["favorite"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "userNum": userNum,
    "nick": nick,
    "age": age,
    "gender": gender,
    "job": job,
    "favorite": List<dynamic>.from(favorite.map((x) => x)),
  };
}
