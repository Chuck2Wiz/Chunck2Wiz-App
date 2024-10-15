import 'package:equatable/equatable.dart';

abstract class MyEvent extends Equatable {
  const MyEvent();

  @override
  List<Object?> get props => [];
}

class GetUserInfoEvent extends MyEvent {}

class DeleteAccount extends MyEvent {}
