import 'package:chuck2wiz/data/server/response/auth/get_user_info_response.dart';
import 'package:equatable/equatable.dart';

class MyState extends Equatable {
  final bool? isLoading;
  final GetUserInfoResponse? getUserInfoResponse;

  const MyState({this.isLoading, this.getUserInfoResponse});

  MyState copyWith({bool? isLoading, GetUserInfoResponse? getUserInfoResponse}) {
    return MyState(
      isLoading: isLoading ?? this.isLoading,
      getUserInfoResponse: getUserInfoResponse ?? this.getUserInfoResponse
    );
  }

  @override
  List<Object?> get props => [isLoading, getUserInfoResponse];
}

class MyInitial extends MyState {}

class GetUserFailure extends MyState {
  final dynamic error;

  const GetUserFailure({super.isLoading, super.getUserInfoResponse, required this.error});
}

class SuccessDelete extends MyState {
  const SuccessDelete({super.isLoading, super.getUserInfoResponse});
}

class DeleteFailure extends MyState {
  final dynamic error;

  const DeleteFailure({super.isLoading, super.getUserInfoResponse, required this.error});
}