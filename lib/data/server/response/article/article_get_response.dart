import 'dart:convert';

class ArticleGetResponse {
  bool success;
  String message;
  Data data;

  ArticleGetResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ArticleGetResponse.fromRawJson(String str) => ArticleGetResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleGetResponse.fromJson(Map<String, dynamic> json) => ArticleGetResponse(
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
  List<SanitizedPost> sanitizedPosts;
  String currentPage;
  int totalPage;

  Data({
    required this.sanitizedPosts,
    required this.currentPage,
    required this.totalPage,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sanitizedPosts: List<SanitizedPost>.from(json["sanitizedPosts"].map((x) => SanitizedPost.fromJson(x))),
    currentPage: json["currentPage"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "sanitizedPosts": List<dynamic>.from(sanitizedPosts.map((x) => x.toJson())),
    "currentPage": currentPage,
    "totalPage": totalPage,
  };
}

class SanitizedPost {
  String id;
  String title;
  String content;
  Author author;
  int likes;
  bool isLikedByUser;
  List<dynamic> comments;
  DateTime createdAt;
  DateTime updatedAt;
  bool isMyArticle;

  SanitizedPost({
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

  factory SanitizedPost.fromRawJson(String str) => SanitizedPost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SanitizedPost.fromJson(Map<String, dynamic> json) => SanitizedPost(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    author: Author.fromJson(json["author"]),
    likes: json["likes"],
    isLikedByUser: json["isLikedByUser"],
    comments: List<dynamic>.from(json["comments"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    isMyArticle: json["isMyArticle"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "author": author.toJson(),
    "likes": likes,
    "isLikedByUser": isLikedByUser,
    "comments": List<dynamic>.from(comments.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "isMyArticle": isMyArticle,
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
    nick: json["nick"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "nick": nick,
  };
}
