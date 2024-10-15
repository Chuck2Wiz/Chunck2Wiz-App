import 'package:chuck2wiz/data/server/response/article/article_get_response.dart';
import 'package:equatable/equatable.dart';

class CommunityState extends Equatable {
  final bool isLoading;
  final ArticleGetResponse? articleGetResponse;
  final int articlePage;
  final String clickArticleId;

  const CommunityState({this.isLoading = false, this.articleGetResponse, this.articlePage = 1, this.clickArticleId = ''});

  @override
  List<Object?> get props => [isLoading, articleGetResponse, articlePage, clickArticleId];

  CommunityState copyWith({
    bool? isLoading,
    ArticleGetResponse? articleGetResponse,
    int? articlePage,
    String? clickArticleId
  }) {
    return CommunityState(
      isLoading: isLoading ?? this.isLoading,
      articleGetResponse: articleGetResponse ?? this.articleGetResponse,
      articlePage: articlePage ?? this.articlePage,
      clickArticleId: clickArticleId ?? this.clickArticleId
    );
  }
}

class CommunityInitial extends CommunityState {}

class CommunityFailure extends CommunityState {
  final dynamic error;

  const CommunityFailure({this.error});
}

class CommunityRefresh extends CommunityState {}
