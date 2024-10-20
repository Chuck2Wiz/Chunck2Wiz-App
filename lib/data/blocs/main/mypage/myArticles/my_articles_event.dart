import 'package:equatable/equatable.dart';

class MyArticlesEvent extends Equatable{
  const MyArticlesEvent();

  @override
  List<Object?> get props => [];
}

class GetMyArticlesEvent extends MyArticlesEvent {
  final int page;

  const GetMyArticlesEvent({this.page = 1});
}

class ClickMyArticleEvent extends MyArticlesEvent {
  final String articleId;

  const ClickMyArticleEvent({required this.articleId});
}