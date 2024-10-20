import 'package:chuck2wiz/data/server/response/aiReport/get_ai_report_response.dart';
import 'package:chuck2wiz/data/server/response/article/article_get_response.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final GetAiReportResponse? getAiReportResponse;
  final ArticleGetResponse? articleGetResponse;

  const HomeState({this.isLoading = false, this.getAiReportResponse, this.articleGetResponse});

  HomeState copyWith({
    bool? isLoading,
    GetAiReportResponse? getAiReportResponse,
    ArticleGetResponse? articleGetResponse
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      getAiReportResponse: getAiReportResponse ?? this.getAiReportResponse,
      articleGetResponse: articleGetResponse ?? this.articleGetResponse
    );
  }

  @override
  List<Object?> get props => [isLoading, getAiReportResponse, articleGetResponse];
}

class HomeInitial extends HomeState {}

class HomeLoadFailure extends HomeState {
  final dynamic error;
  final HomeState previousState;

  const HomeLoadFailure({required this.error, required this.previousState});
}

class HomeRefresh extends HomeState {}