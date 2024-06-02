part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent{}

final class WeatherFetch extends WeatherEvent {
  WeatherFetch({required this.cityName});
  final String cityName;
}
