import 'package:equatable/equatable.dart';

abstract class MyEvent extends Equatable {
  const MyEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends MyEvent {}

class LoadWrittenPosts extends MyEvent {}

class LoadSavedReports extends MyEvent {}

class Logout extends MyEvent {}

class DeleteAccount extends MyEvent {}
