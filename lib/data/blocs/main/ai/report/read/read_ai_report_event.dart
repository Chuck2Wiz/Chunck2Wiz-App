abstract class ReadAiReportEvent {}

class GetAiReportReadEvent extends ReadAiReportEvent {
  final String aiReportId;

  GetAiReportReadEvent({required this.aiReportId});
}
