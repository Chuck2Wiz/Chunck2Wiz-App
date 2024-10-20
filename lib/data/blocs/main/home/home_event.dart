import 'package:equatable/equatable.dart';

abstract class HomeEvent {}

class GetLoadHomeDataEvent extends HomeEvent {}

class ClickMyAiReportEvent extends HomeEvent {
  final String aiReportId;

  ClickMyAiReportEvent({required this.aiReportId});
}

class ClickCommunityArticleEvent extends HomeEvent {
  final String articleId;

  ClickCommunityArticleEvent({required this.articleId});
}

class RefreshHomeEvent extends HomeEvent {}