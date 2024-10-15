import 'package:meta/meta.dart';
import 'dart:convert';

class ArticleReadResponse {
  bool success;
  String message;
  Data? data;

  ArticleReadResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ArticleReadResponse.fromRawJson(String str) => ArticleReadResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleReadResponse.fromJson(Map<String, dynamic> json) => ArticleReadResponse(
    success: json["success"] ?? false,
    message: json["message"] ?? '',
    data: json["data"] != null ? Data.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String id;
  String title;
  String content;
  Author? author;
  int likes;
  bool isLikedByUser;
  List<Comment> comments;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool isMyArticle;

  Data({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.likes,
    required this.isLikedByUser,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.isMyArticle,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] ?? '',
    title: json["title"] ?? '',
    content: json["content"] ?? '',
    author: json["author"] != null ? Author.fromJson(json["author"]) : null,
    likes: json["likes"] ?? 0,
    isLikedByUser: json["isLikedByUser"] ?? false,
    comments: json["comments"] != null
        ? List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x)))
        : [],
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
    isMyArticle: json["isMyArticle"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "author": author?.toJson(),
    "likes": likes,
    "isLikedByUser": isLikedByUser,
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "isMyArticle": isMyArticle,
  };
}

class Author {
  String? nick;

  Author({
    required this.nick,
  });

  factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    nick: json["nick"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "nick": nick,
  };
}

class Comment {
  Author? author;
  String id;
  String postId;
  String content;
  List<Comment> replies;
  DateTime? createdAt;
  DateTime? updatedAt;
  int v;
  bool isMyComment;
  bool isMyReply;

  Comment({
    required this.author,
    required this.id,
    required this.postId,
    required this.content,
    required this.replies,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isMyComment,
    required this.isMyReply,
  });

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    author: json["author"] != null ? Author.fromJson(json["author"]) : null,
    id: json["_id"] ?? '',
    postId: json["postId"] ?? '',
    content: json["content"] ?? '',
    replies: json["replies"] != null
        ? List<Comment>.from(json["replies"].map((x) => Comment.fromJson(x)))
        : [],
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
    v: json["__v"] ?? 0,
    isMyComment: json["isMyComment"] ?? false,
    isMyReply: json["isMyReply"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "author": author?.toJson(),
    "_id": id,
    "postId": postId,
    "content": content,
    "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "isMyComment": isMyComment,
    "isMyReply": isMyReply,
  };
}
