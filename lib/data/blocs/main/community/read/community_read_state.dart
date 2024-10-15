import 'package:chuck2wiz/data/server/response/article/article_get_response.dart';
import 'package:chuck2wiz/data/server/response/article/article_read_response.dart';
import 'package:equatable/equatable.dart';

class CommunityReadState extends Equatable {
  final bool isLoading;
  final String? articleId;
  final ArticleReadResponse? articleReadResponse;
  final String? comment;

  const CommunityReadState({this.isLoading = false, this.articleId, this.articleReadResponse, this.comment});

  CommunityReadState copyWith({
    bool? isLoading,
    String? articleId,
    ArticleReadResponse? articleReadResponse,
    String? comment
  }) {
    return CommunityReadState(
        isLoading: isLoading ?? this.isLoading,
        articleId: articleId ?? this.articleId,
        articleReadResponse: articleReadResponse ?? this.articleReadResponse,
        comment: comment ?? this.comment
    );
  }

  @override
  List<Object?> get props => [isLoading, articleId, articleReadResponse, comment];
}

class CommunityReadInitial extends CommunityReadState {}

class CommunityReadFailure extends CommunityReadState {
  final dynamic error;

  const CommunityReadFailure({
    this.error,
    super.isLoading,
    super.articleId,
    super.articleReadResponse,
    super.comment,
  });

  @override
  List<Object?> get props => [error, isLoading, articleId, articleReadResponse, comment];
}

class CommentWriteSuccess extends CommunityReadState {
  const CommentWriteSuccess({
    super.isLoading,
    super.articleId,
    super.articleReadResponse,
    super.comment
  });
}