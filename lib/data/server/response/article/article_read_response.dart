import 'package:meta/meta.dart';
import 'dart:convert';

class ArticleReadResponse {
  bool success;
  String message;
  Data data;

  ArticleReadResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ArticleReadResponse.fromRawJson(String str) => ArticleReadResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleReadResponse.fromJson(Map<String, dynamic> json) => ArticleReadResponse(
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
  String title;
  String content;
  Author author;
  int likes;
  List<Comment> comments;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.likes,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    title: json["title"],
    content: json["content"],
    author: Author.fromJson(json["author"]),
    likes: json["likes"],
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "content": content,
    "author": author.toJson(),
    "likes": likes,
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Author {
  String nick;

  Author({
    required this.nick,
  });

  factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    nick: json["nick"],
  );

  Map<String, dynamic> toJson() => {
    "nick": nick,
  };
}

class Comment {
  Author author;
  String id;
  String postId;
  String content;
  List<dynamic> replies;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Comment({
    required this.author,
    required this.id,
    required this.postId,
    required this.content,
    required this.replies,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    author: Author.fromJson(json["author"]),
    id: json["_id"],
    postId: json["postId"],
    content: json["content"],
    replies: List<dynamic>.from(json["replies"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "author": author.toJson(),
    "_id": id,
    "postId": postId,
    "content": content,
    "replies": List<dynamic>.from(replies.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}