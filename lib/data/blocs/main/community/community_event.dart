import 'package:equatable/equatable.dart';

class CommunityEvent extends Equatable {
  const CommunityEvent();

  @override
  List<Object?> get props => [];
}

class GetArticles extends CommunityEvent {
  final int page;

  const GetArticles({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class ClickArticle extends CommunityEvent {
  final String articleId;

  const ClickArticle({required this.articleId});
}

class RefreshArticle extends CommunityEvent {}