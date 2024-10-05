import 'dart:convert';

class ArticleCreateVo {
  String title;
  String content;
  Author author;

  ArticleCreateVo({
    required this.title,
    required this.content,
    required this.author,
  });

  factory ArticleCreateVo.fromRawJson(String str) => ArticleCreateVo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleCreateVo.fromJson(Map<String, dynamic> json) => ArticleCreateVo(
    title: json["title"],
    content: json["content"],
    author: Author.fromJson(json["author"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
    "author": author.toJson(),
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
