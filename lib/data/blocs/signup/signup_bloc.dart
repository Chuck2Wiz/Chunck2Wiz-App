import 'package:bloc/bloc.dart';
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
  }

  void _onUserNumChanged(UserNumChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(userNum: event.userNum));
  }

  void _onNicknameChanged(NicknameChanged event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(nick: event.nickname, nickError: false));
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

  Future<void> _onFormSubmitted(FormSubmitted event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(isSubmitting: true, isSuccess: false, isError: false, nickError: false));
    try {
      await userRepository.registerUser(
        userNum: '1234',
        nick: state.nick,
        age: state.age,
        gender: state.gender,
        job: state.job,
        favorite: state.favorite,
      );
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, isError: true, nickError: true));
    }
  }
}