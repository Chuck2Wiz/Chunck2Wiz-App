import 'package:chuck2wiz/data/server/response/aiReport/get_read_ai_report_response.dart';
import 'package:equatable/equatable.dart';

class ReadAiReportState extends Equatable{
  final bool isLoading;
  final String? aiReportId;
  final GetReadAiReportResponse? getReadAiReportResponse;

  const ReadAiReportState({this.isLoading = false, this.aiReportId, this.getReadAiReportResponse});

  ReadAiReportState copyWith({
    bool? isLoading,
    String? aiReportId,
    GetReadAiReportResponse? getReadAiReportResponse
  }) {
    return ReadAiReportState(
      isLoading: isLoading ?? this.isLoading,
      aiReportId: aiReportId ?? this.aiReportId,
      getReadAiReportResponse: getReadAiReportResponse ?? this.getReadAiReportResponse
    );
  }

  @override
  List<Object?> get props => [isLoading, aiReportId, getReadAiReportResponse];
}

class ReadAiReportInitial extends ReadAiReportState {}

class ReadAiReportFailure extends ReadAiReportState {}