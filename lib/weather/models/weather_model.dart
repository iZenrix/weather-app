// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherModel {
  final dynamic currentTemp;
  final String currentSky;
  final dynamic currentPressure;
  final dynamic currentWindSpeed;
  final dynamic currentHumidity;
  final List<HourlyWeatherModel> hourlyWeather;
  final String cityName;
  final dynamic feelsLike;
  final dynamic tempMin;
  final dynamic tempMax;

  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
    required this.hourlyWeather,
    required this.cityName,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
  });

  WeatherModel copyWith({
    dynamic currentTemp,
    String? currentSky,
    dynamic currentPressure,
    dynamic currentWindSpeed,
    dynamic currentHumidity,
    List<HourlyWeatherModel>? hourlyWeather,
    String? cityName,
    dynamic feelsLike,
    dynamic tempMin,
    dynamic tempMax,
  }) {
    return WeatherModel(
      currentTemp: currentTemp ?? this.currentTemp,
      currentSky: currentSky ?? this.currentSky,
      currentPressure: currentPressure ?? this.currentPressure,
      currentWindSpeed: currentWindSpeed ?? this.currentWindSpeed,
      currentHumidity: currentHumidity ?? this.currentHumidity,
      hourlyWeather: hourlyWeather ?? this.hourlyWeather,
      cityName: cityName ?? this.cityName,
      feelsLike: feelsLike ?? this.feelsLike,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
      'currentHumidity': currentHumidity,
      'hourlyWeather': hourlyWeather.map((x) => x.toMap()).toList(),
      'cityName': cityName,
      'feelsLike': feelsLike,
      'tempMin': tempMin,
      'tempMax': tempMax,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];
    final hourlyWeatherData = map['list'] as List<dynamic>;

    return WeatherModel(
      currentTemp: currentWeatherData['main']['temp'],
      currentSky: currentWeatherData['weather'][0]['main'] as String,
      currentPressure: currentWeatherData['main']['pressure'],
      currentWindSpeed: currentWeatherData['wind']['speed'],
      currentHumidity: currentWeatherData['main']['humidity'],
      hourlyWeather: hourlyWeatherData
          .map((e) => HourlyWeatherModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      cityName: map['city']['name'] as String,
      feelsLike: currentWeatherData['main']['feels_like'],
      tempMin: currentWeatherData['main']['temp_min'],
      tempMax: currentWeatherData['main']['temp_max'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(currentTemp: $currentTemp, '
        'currentSky: $currentSky, '
        'currentPressure: $currentPressure, '
        'currentWindSpeed: $currentWindSpeed, '
        'currentHumidity: $currentHumidity, '
        'hourlyWeather: $hourlyWeather, '
        'cityName: $cityName, '
        'feelsLike: $feelsLike, '
        'tempMin: $tempMin, '
        'tempMax: $tempMax)';
  }
}

class HourlyWeatherModel {
  HourlyWeatherModel({
    required this.sky,
    required this.temp,
    required this.time,
  });

  final String sky;
  final dynamic temp;
  final DateTime time;

  HourlyWeatherModel copyWith({
    String? sky,
    dynamic temp,
    DateTime? time,
  }) {
    return HourlyWeatherModel(
      sky: sky ?? this.sky,
      temp: temp ?? this.temp,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sky': sky,
      'temp': temp,
      'time': time.toIso8601String(),
    };
  }

  factory HourlyWeatherModel.fromMap(Map<String, dynamic> map) {
    return HourlyWeatherModel(
      sky: map['weather'][0]['main'] as String,
      temp: map['main']['temp'] as dynamic,
      time: DateTime.parse(map['dt_txt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory HourlyWeatherModel.fromJson(String source) =>
      HourlyWeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'HourlyWeatherModel(sky: $sky, temp: $temp, time: $time)';
}
