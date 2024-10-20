import 'package:equatable/equatable.dart';

abstract class MyAiReportEvent {}

class GetAiReportEvent extends MyAiReportEvent {}

class ClickAiReportEvent extends MyAiReportEvent {
  final String aiReportId;

  ClickAiReportEvent({required this.aiReportId});
}