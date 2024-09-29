import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.nick = '',
    this.age = 0,
    this.gender = '',
    this.job = '',
    this.favorite = const [],
    this.checkNickInfo = const CheckNickInfo(),
    this.submitInfo = const SubmitInfo(),
    this.isLoading = false,
  });

  final String nick;
  final int age;
  final String gender;
  final String job;
  final List<String> favorite;
  final CheckNickInfo checkNickInfo;
  final SubmitInfo submitInfo;
  final bool isLoading;

  @override
  List<Object?> get props => [
    nick,
    age,
    gender,
    job,
    favorite,
    checkNickInfo,
    submitInfo,
    isLoading
  ];

  SignUpState copyWith({
    String? userNum,
    String? nick,
    int? age,
    String? gender,
    String? job,
    List<String>? favorite,
    CheckNickInfo? checkNickInfo,
    SubmitInfo? submitInfo,
    bool? isLoading
  }) {
    return SignUpState(
      nick: nick ?? this.nick,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      job: job ?? this.job,
      favorite: favorite ?? this.favorite,
      checkNickInfo: checkNickInfo ?? this.checkNickInfo,
      submitInfo: submitInfo ?? this.submitInfo,
      isLoading: isLoading ?? this.isLoading
    );
  }

  bool get isValid {
    return nick.isNotEmpty &&
        checkNickInfo.isAvailable == true &&
        age > 0 &&
        gender.isNotEmpty &&
        job.isNotEmpty &&
        favorite.length <= 3;
  }
}


class CheckNickInfo {
  final bool? isAvailable;
  final String? errorMsg;

  const CheckNickInfo({this.isAvailable, this.errorMsg});
}

class SubmitInfo {
  final bool? isSuccess;
  final String? errorMsg;

  const SubmitInfo({this.isSuccess, this.errorMsg});
}