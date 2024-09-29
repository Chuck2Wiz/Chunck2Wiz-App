import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/db/shared_preferences_helper.dart';
import 'package:chuck2wiz/data/http/base_server_exception.dart';
import 'signup_event.dart';
import 'signup_state.dart';
import 'package:chuck2wiz/data/repository/signup_repository.dart';

class SignUpBloc extends Bloc<SignupEvent, SignUpState> {
  final SignUpRepository userRepository;

  SignUpBloc(this.userRepository) : super(const SignUpState()) {
    on<UserNumChanged>(_onUserNumChanged);
    on<NicknameChanged>(_onNicknameChanged);
    on<AgeChanged>(_onAgeChanged);
    on<GenderChanged>(_onGenderChanged);
    on<JobChanged>(_onJobChanged);
    on<FavoriteChanged>(_onFavoriteChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<CheckNickInfoChanged>(_onCheckNickChanged);
  }

  void _onUserNumChanged(UserNumChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(userNum: event.userNum));
  }

  void _onNicknameChanged(NicknameChanged event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(nick: event.nickname));
  }

  void _onAgeChanged(AgeChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(age: event.age));
  }

  void _onGenderChanged(GenderChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  void _onJobChanged(JobChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(job: event.job));
  }

  void _onFavoriteChanged(FavoriteChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(favorite: event.favorite));
  }

  Future<void> _onCheckNickChanged(CheckNickInfoChanged event, Emitter<SignUpState> emit) async {
    try {
      final response = await userRepository.checkNick(
        nick: state.nick
      );

      if (response.data.exists) {
        emit(state.copyWith(checkNickInfo: const CheckNickInfo(isAvailable: false)));
      } else {
        emit(state.copyWith(checkNickInfo: const CheckNickInfo(isAvailable: true)));
      }

    } catch(e) {
      print("Error: ${e}");
      if (e is BaseServerException) {
        emit(state.copyWith(checkNickInfo: CheckNickInfo(errorMsg: e.message)));
      } else {
        emit(state.copyWith(checkNickInfo: CheckNickInfo(errorMsg: e.toString())));
      }
    }
  }

  Future<void> _onFormSubmitted(FormSubmitted event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final userNum = await SharedPreferencesHelper.getUserNum() ?? '';

      print("userNum: $userNum");

      final response = await userRepository.register(
          userNum: userNum,
          nick: state.nick,
          age: state.age,
          gender: state.gender,
          job: state.job,
          favorite: state.favorite
      );

      await SharedPreferencesHelper.saveToken(response.data.token);

      emit(state.copyWith(submitInfo: const SubmitInfo(isSuccess: true)));
    } catch (e) {
      if(e is BaseServerException) {
        emit(state.copyWith(submitInfo: SubmitInfo(isSuccess: false, errorMsg: e.message)));
      } else {
        emit(state.copyWith(submitInfo: SubmitInfo(isSuccess: false, errorMsg: e.toString())));
      }
    }
  }
}