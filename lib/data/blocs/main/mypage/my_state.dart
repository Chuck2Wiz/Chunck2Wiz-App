import 'package:equatable/equatable.dart';

abstract class MyState extends Equatable {
  const MyState();

  @override
  List<Object?> get props => [];
}

class MyInitial extends MyState {}

class MyProfile extends MyState {
  final String nick;

  const MyProfile(this.nick);

  @override
  List<Object?> get props => [nick];
}

class MyWrittenPost extends MyState {
  final List<String> posts;

  const MyWrittenPost(this.posts);

  @override
  List<Object?> get props => [posts];
}

class MySavedReport extends MyState {
  final List<String> reports;

  const MySavedReport(this.reports);

  @override
  List<Object?> get props => [reports];
}

class MyLogoutSuccess extends MyState {}

class MyDeleteAccountSuccess extends MyState {}
