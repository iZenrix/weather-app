import 'package:equatable/equatable.dart';

abstract class TimeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateTime extends TimeEvent {}
