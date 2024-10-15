import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/my_event.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/my_state.dart';
import 'package:chuck2wiz/data/server/request/auth/auth_request.dart';
import '../../../db/shared_preferences_helper.dart';

class MyBloc extends Bloc<MyEvent, MyState> {
  MyBloc() : super(MyInitial()) {
    on<GetUserInfoEvent>(_onGetUserInfo);
    on<DeleteAccount>(_onDeleteAccount);
  }

  Future<void> _onGetUserInfo(GetUserInfoEvent event, Emitter<MyState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final userNum = await SharedPreferencesHelper.getUserNum();

      if(userNum == null) {
        throw Exception("userNum is NULL");
      }

      final response = await AuthRequest().getUserInfo(userNum);

      emit(state.copyWith(getUserInfoResponse: response));
    } catch(e) {
      emit(GetUserFailure(error: e));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onDeleteAccount(DeleteAccount event, Emitter<MyState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final userNum = await SharedPreferencesHelper.getUserNum();

      if(userNum == null) {
        throw Exception("userNum is NULL");
      }

      final response = await AuthRequest().deleteUser(userNum);

      if(response.success) emit(SuccessDelete());
    } catch (error) {
      emit(DeleteFailure(error: error));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
