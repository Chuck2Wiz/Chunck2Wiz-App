import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class ChangedBottomNavIndex extends MainEvent {
  final int bottomNavIndex;

  const ChangedBottomNavIndex(this.bottomNavIndex);
}