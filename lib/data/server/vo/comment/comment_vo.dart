import 'package:meta/meta.dart';
import 'dart:convert';

class CommentVo {
  String postId;
  Author author;
  String content;

  CommentVo({
    required this.postId,
    required this.author,
    required this.content,
  });

  factory CommentVo.fromRawJson(String str) => CommentVo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentVo.fromJson(Map<String, dynamic> json) => CommentVo(
    postId: json["postId"],
    author: Author.fromJson(json["author"]),
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "author": author.toJson(),
    "content": content,
  };
}

class Author {
  String userNum;
  String nick;

  Author({
    required this.userNum,
    required this.nick,
  });

  factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    userNum: json["userNum"],
    nick: json["nick"],
  );

  Map<String, dynamic> toJson() => {
    "userNum": userNum,
    "nick": nick,
  };
}
