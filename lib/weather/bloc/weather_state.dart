part of 'weather_bloc.dart';

@immutable
sealed class WeatherState{}

final class WeatherInitial extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  WeatherSuccess({required this.weatherModel});
  final WeatherModel weatherModel;
}

final class WeatherFailure extends WeatherState {
  WeatherFailure(this.error);
  final String error;
}

final class WeatherLoading extends WeatherState {}
