import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable{
  const MainState();

  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {}

class MainLoading extends MainState {}

class BottomNavIndex extends MainState {
  final int bottomNavIndex;

  const BottomNavIndex({required this.bottomNavIndex});

  @override
  List<Object> get props => [bottomNavIndex];
}
