import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/my_event.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/my_state.dart';
import '../../../db/shared_preferences_helper.dart';

class MyBloc extends Bloc<MyEvent, MyState> {
  MyBloc(MyInitial myInitial) : super(MyInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<Logout>(_onLogout);
    on<DeleteAccount>(_onDeleteAccount);
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter<MyState> emit) async {
    try {
      final String? nick = await SharedPreferencesHelper.getNick();
      if (nick != null) {
        emit(MyProfile(nick));
      }
    } catch (error) {
      print('Failed to load profile: $error');
    }
  }

  Future<void> _onLogout(Logout event, Emitter<MyState> emit) async {
    try {
      emit(MyLogoutSuccess());
    } catch (error) {
      print('Failed to logout: $error');
    }
  }

  Future<void> _onDeleteAccount(DeleteAccount event, Emitter<MyState> emit) async {
    try {
      emit(MyDeleteAccountSuccess());
    } catch (error) {
      print('Failed to delete account: $error');
    }
  }
}
