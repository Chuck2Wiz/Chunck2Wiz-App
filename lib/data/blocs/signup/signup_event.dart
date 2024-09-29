import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class UserNumChanged extends SignupEvent {
  final String userNum;

  const UserNumChanged(this.userNum);

  @override
  List<Object> get props => [userNum];
}

class NicknameChanged extends SignupEvent {
  final String nickname;

  const NicknameChanged(this.nickname);

  @override
  List<Object> get props => [nickname];
}

class AgeChanged extends SignupEvent {
  final int age;

  const AgeChanged(this.age);

  @override
  List<Object> get props => [age];
}

class GenderChanged extends SignupEvent {
  final String gender;

  const GenderChanged(this.gender);

  @override
  List<Object> get props => [gender];
}

class JobChanged extends SignupEvent {
  final String job;

  const JobChanged(this.job);

  @override
  List<Object> get props => [job];
}

class CheckNickInfoChanged extends SignupEvent {
  final String checkNickInfo;

  const CheckNickInfoChanged(this.checkNickInfo);

  @override
  List<Object> get props => [checkNickInfo];
}

class FavoriteChanged extends SignupEvent {
  final List<String> favorite;

  const FavoriteChanged(this.favorite);

  @override
  List<Object> get props => [favorite];
}

class FormSubmitted extends SignupEvent {
  final String nick;
  final int age;
  final String gender;
  final String job;
  final List<String> favorite;

  const FormSubmitted({
    required this.nick,
    required this.age,
    required this.gender,
    required this.job,
    required this.favorite,
  });

  @override
  List<Object> get props => [nick, age, gender, job, favorite];
}
