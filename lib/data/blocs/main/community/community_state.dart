import 'package:chuck2wiz/data/server/response/article/article_get_response.dart';
import 'package:equatable/equatable.dart';

class CommunityState extends Equatable {
  final ArticleGetResponse? articleGetResponse;
  final int articlePage;

  const CommunityState({this.articleGetResponse, this.articlePage = 1});

  @override
  List<Object?> get props => [articleGetResponse, articlePage];

  CommunityState copyWith({
    ArticleGetResponse? articleGetResponse,
    int? articlePage,
  }) {
    return CommunityState(
      articleGetResponse: articleGetResponse ?? this.articleGetResponse,
      articlePage: articlePage ?? this.articlePage,
    );
  }
}

class CommunityInitial extends CommunityState {}

class CommunityFailure extends CommunityState {
  final dynamic error;

  const CommunityFailure({this.error});
}

class CommunityLoading extends CommunityState {}
