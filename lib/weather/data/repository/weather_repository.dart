import 'dart:convert';
import 'package:learn_bloc/weather/data/data_provider/weather_data_provider.dart';
import 'package:learn_bloc/weather/models/weather_model.dart';

class WeatherRepository{
  WeatherRepository(this.weatherDataProvider);

  final WeatherDataProvider weatherDataProvider;

  Future<WeatherModel> getWeatherFromProvider(String cityName) async {
    try {
      final weatherData = await weatherDataProvider.getCurrentWeather(cityName);

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw data['message'] as String;
      }

      return WeatherModel.fromMap(data as Map<String, dynamic>);
    } catch (e) {
      throw e.toString();
    }
  }
}