import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/weather/data/repository/weather_repository.dart';
import 'package:learn_bloc/weather/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherFetch>(_getCurrentWeather);
  }

  final WeatherRepository weatherRepository;

  Future<void> _getCurrentWeather(
    WeatherFetch event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final cityName = event.cityName;

      final weather = await weatherRepository.getWeatherFromProvider(cityName);
      emit(WeatherSuccess(weatherModel: weather));
    } catch (e) {
      emit(WeatherFailure(e.toString()));
    }
  }

}
