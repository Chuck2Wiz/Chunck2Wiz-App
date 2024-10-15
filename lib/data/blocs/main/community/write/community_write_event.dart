import 'package:equatable/equatable.dart';

class CommunityWriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class WriteTitle extends CommunityWriteEvent {
  final String title;

  WriteTitle(this.title);

  @override
  List<Object?> get props => [title];
}

class WriteContent extends CommunityWriteEvent {
  final String content;

  WriteContent(this.content);

  @override
  List<Object?> get props => [content];
}

class CompleteWrite extends CommunityWriteEvent {
  final String content;
  final String title;

  CompleteWrite({
    required this.content,
    required this.title,
  });
}

