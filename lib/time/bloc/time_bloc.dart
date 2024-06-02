import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/time/bloc/time_event.dart';
import 'package:learn_bloc/time/bloc/time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  TimeBloc() : super(TimeState(currentTime: DateTime.now())) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(UpdateTime());
    });

    on<UpdateTime>((event, emit) {
      emit(TimeState(currentTime: DateTime.now()));
    });
  }

  late Timer _timer;

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
