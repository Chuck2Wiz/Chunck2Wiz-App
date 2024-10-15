import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/main_event.dart';
import 'package:chuck2wiz/data/blocs/main/main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()){
    on<ChangedBottomNavIndex>(_onChangedBottomNavIndex);
  }

  void _onChangedBottomNavIndex(ChangedBottomNavIndex event, Emitter<MainState> emit) {
    emit(BottomNavIndex(bottomNavIndex: event.bottomNavIndex));
  }
}

