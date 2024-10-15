import 'package:equatable/equatable.dart';

class CommunityWriteState extends Equatable {
  final bool isLoading;
  final String title;
  final String content;

  const CommunityWriteState({this.title = '', this.content = '', this.isLoading = false});

  CommunityWriteState copyWith({String? title, String? content, bool? isLoading}) {
    return CommunityWriteState(
        title: title ?? this.title, content: content ?? this.content, isLoading: isLoading ?? this.isLoading);
  }

  bool get isValid {
    return title.isNotEmpty && content.isNotEmpty;
  }

  @override
  List<Object?> get props => [title, content];
}

class CommunityWriteInitial extends CommunityWriteState {}

class CommunityWriteSuccess extends CommunityWriteState {}

class CommunityWriteFailure extends CommunityWriteState {
  final dynamic error;

  const CommunityWriteFailure({this.error});
}