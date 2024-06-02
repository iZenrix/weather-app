import 'package:equatable/equatable.dart';

class TimeState extends Equatable {
  const TimeState({required this.currentTime});
  final DateTime currentTime;

  @override
  List<Object> get props => [currentTime];
}
