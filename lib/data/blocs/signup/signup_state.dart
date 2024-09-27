import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.userNum = '',
    this.nick = '',
    this.age = 0,
    this.gender = '',
    this.job = '',
    this.favorite = const [],
    this.nickError = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isError = false,
  });

  final String userNum;
  final String nick;
  final int age;
  final String gender;
  final String job;
  final List<String> favorite;
  final bool nickError;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isError;

  @override
  List<Object?> get props => [
    userNum,
    nick,
    age,
    gender,
    job,
    favorite,
    nickError,
    isSubmitting,
    isSuccess,
    isError,
  ];

  SignUpState copyWith({
    String? userNum,
    String? nick,
    int? age,
    String? gender,
    String? job,
    List<String>? favorite,
    bool? nickError,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isError,
  }) {
    return SignUpState(
      userNum: userNum ?? this.userNum,
      nick: nick ?? this.nick,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      job: job ?? this.job,
      favorite: favorite ?? this.favorite,
      nickError: nickError ?? this.nickError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
    );
  }

  bool get isValid {
    return nick.isNotEmpty &&
        age > 0 &&
        gender.isNotEmpty &&
        job.isNotEmpty &&
        favorite.length <= 3 &&
        !nickError;
  }
}
