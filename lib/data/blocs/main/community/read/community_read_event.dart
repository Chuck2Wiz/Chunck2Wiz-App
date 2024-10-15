import 'package:equatable/equatable.dart';

class CommunityReadEvent extends Equatable{
  const CommunityReadEvent();

  @override
  List<Object?> get props => [];
}

class GetArticleRead extends CommunityReadEvent {
  final String articleId;

  const GetArticleRead({required this.articleId});

  @override
  List<Object?> get props => [articleId];
}

class CommentWrite extends CommunityReadEvent {
  final String comment;

  const CommentWrite({required this.comment});

  @override
  List<Object?> get props => [comment];
}

class PostComment extends CommunityReadEvent {
  final String? comment;

  const PostComment({this.comment});

  @override
  List<Object?> get props => [comment];
}