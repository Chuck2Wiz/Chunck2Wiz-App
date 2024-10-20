import 'package:chuck2wiz/data/server/response/aiReport/get_ai_report_response.dart';
import 'package:chuck2wiz/data/server/response/aiReport/get_read_ai_report_response.dart';
import 'package:equatable/equatable.dart';

class MyAiReportState extends Equatable {
  final bool isLoading;
  final GetAiReportResponse? getAiReportResponse;
  final String? clickAiReportId;

  const MyAiReportState({this.isLoading = false, this.clickAiReportId, this.getAiReportResponse});

  MyAiReportState copyWith({
    bool? isLoading,
    GetAiReportResponse? getAiReportResponse,
    String? clickAiReportId
  }) {
    return MyAiReportState(
        isLoading: isLoading ?? this.isLoading,
        clickAiReportId: clickAiReportId ?? this.clickAiReportId,
        getAiReportResponse: getAiReportResponse ?? this.getAiReportResponse
    );
  }

  @override
  List<Object?> get props => [isLoading, getAiReportResponse, clickAiReportId];
}

class MyAiReportInitial extends MyAiReportState {}

class MyAiReportFailure extends MyAiReportState {
  final dynamic error;

  const MyAiReportFailure({required this.error, super.isLoading, super.clickAiReportId, super.getAiReportResponse});
}