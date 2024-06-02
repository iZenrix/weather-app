import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:learn_bloc/time/bloc/time_bloc.dart';
import 'package:learn_bloc/time/bloc/time_state.dart';

class TimeScreen extends StatelessWidget {
  const TimeScreen({required this.commonTextColor, super.key});

  final Color commonTextColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeBloc, TimeState>(
      builder: (context, timeState) {
        return Text(
          DateFormat('EEEE, HH.mm')
              .format(timeState.currentTime),
          style: TextStyle(
            color: commonTextColor,
            fontSize: 18,
          ),
        );
      },
    );
  }
}
