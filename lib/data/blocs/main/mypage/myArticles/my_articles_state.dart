import 'package:chuck2wiz/data/server/response/article/my_articles_response.dart';
import 'package:equatable/equatable.dart';

class MyArticlesState extends Equatable{
  final bool isLoading;
  final MyArticlesResponse? myArticlesResponse;
  final int articlePage;
  final String clickArticleId;

  const MyArticlesState({
    this.isLoading = false,
    this.myArticlesResponse,
    this.articlePage = 1,
    this.clickArticleId = ''
  });

  MyArticlesState copyWith({
    bool? isLoading,
    MyArticlesResponse? myArticleResponse,
    int? articlePage,
    String? clickArticleId
  }) {
    return MyArticlesState(
      isLoading: isLoading ?? this.isLoading,
      myArticlesResponse: myArticleResponse ?? this.myArticlesResponse,
      articlePage: articlePage ?? this.articlePage,
      clickArticleId: clickArticleId ?? this.clickArticleId
    );
  }
  @override
  List<Object?> get props => [isLoading, myArticlesResponse, articlePage, clickArticleId];
}

class MyArticlesInitial extends MyArticlesState {}

class MyArticlesFailure extends MyArticlesState {
  final dynamic error;

  const MyArticlesFailure({this.error});
}