import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/time/presentation/time_screen.dart';
import 'package:learn_bloc/weather/bloc/weather_bloc.dart';
import 'package:learn_bloc/weather/presentation/screens/error_screen.dart';
import 'package:learn_bloc/weather/presentation/widgets/highlight_item.dart';
import 'package:learn_bloc/weather/presentation/widgets/hourly_item.dart';
import 'package:learn_bloc/weather/presentation/widgets/search_city_field.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final cityNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherFetch(cityName: 'Surabaya'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, weatherState) {
          if (weatherState is WeatherFailure) {
            return ErrorScreen(
              cityNameController: cityNameController,
              error: weatherState.error,
              onRetry: () {
                context.read<WeatherBloc>().add(
                      WeatherFetch(
                        cityName: cityNameController.text,
                      ),
                    );
                cityNameController.clear();
              },
              onSubmit: (value) {
                context.read<WeatherBloc>().add(
                      WeatherFetch(
                        cityName: cityNameController.text,
                      ),
                    );
                cityNameController.clear();
              },
            );
          }

          if (weatherState is! WeatherSuccess) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          final data = weatherState.weatherModel;

          final currentTemp = data.currentTemp - 273.15;

          final currentSky = data.currentSky;
          final currentPressure = data.currentPressure;
          final currentWindSpeed = data.currentWindSpeed;
          final currentHumidity = data.currentHumidity;
          final hourlyWeather = data.hourlyWeather;

          final tempMin = data.tempMin - 273.15;
          final tempMax = data.tempMax - 273.15;
          final cityName = data.cityName;
          final feelsLike = data.feelsLike - 273.15;

          final commonTextColor =
              currentSky == 'Rain' ? Colors.white : Colors.black;

          final skyColor = currentSky == 'Rain'
              ? const Color(0xff44C2E4)
              : currentSky == 'Clouds'
                  ? const Color(0xff3591A6)
                  : const Color(0xffD8920B);

          final bgContainerColor = currentSky == 'Rain'
              ? const Color(0xffffffff)
              : currentSky == 'Clouds'
                  ? const Color(0xff3591A6)
                  : const Color(0xffE6C705);

          return Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: currentSky == 'Clouds'
                        ? [
                            const Color(0xffCDE8E5),
                            const Color(0xffEEF7FF),
                          ]
                        : currentSky == 'Rain'
                            ? [
                                const Color(0xff0B60B0),
                                const Color(0xff40A2D8),
                              ]
                            : [
                                Colors.yellow.shade200,
                                Colors.yellow.shade400,
                              ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    SearchCityField(
                      cityNameController: cityNameController,
                      onSubmitted: (value) {
                        context.read<WeatherBloc>().add(
                              WeatherFetch(
                                cityName: cityNameController.text,
                              ),
                            );
                        cityNameController.clear();
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${currentTemp.toStringAsFixed(2)}° C',
                                style: TextStyle(
                                  color: commonTextColor,
                                  fontSize: 50,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    cityName,
                                    style: TextStyle(
                                      color: commonTextColor,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Icon(
                                    Icons.location_on,
                                    color: commonTextColor,
                                  ),
                                ],
                              ),
                              Text(
                                currentSky,
                                style: TextStyle(
                                  color: skyColor,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Text(
                                '${tempMin.toStringAsFixed(2) as String}° / ${tempMax.toStringAsFixed(2) as String}° Feels like ${feelsLike.toStringAsFixed(2) as String}° C',
                                style: TextStyle(
                                  color: commonTextColor,
                                  fontSize: 18,
                                ),
                              ),
                              TimeScreen(commonTextColor: commonTextColor),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Image.asset(
                                currentSky == 'Clouds'
                                    ? 'assets/images/weather/clouds.png'
                                    : currentSky == 'Rain'
                                        ? 'assets/images/weather/rain.png'
                                        : 'assets/images/weather/clear.png',
                                width: 125,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Text(
                      'Hourly Forecast',
                      style: TextStyle(
                        color: commonTextColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        color: bgContainerColor.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white),
                      ),
                      alignment: Alignment.center,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: hourlyWeather.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final hourlyForecast = hourlyWeather[index];
                          final hourlySky = hourlyForecast.sky;
                          final hourlyTemp = hourlyForecast.temp - 273.15;
                          final time = DateTime.parse(
                            hourlyForecast.time.toString(),
                          );

                          final skyTextColor = currentSky == 'Rain'
                              ? const Color(0xffffffff)
                              : currentSky == 'Clouds'
                                  ? const Color(0xff3591A6)
                                  : const Color(0xffD8920B);

                          return HourlyItem(
                            time: time,
                            hourlySky: hourlySky,
                            skyTextColor: skyTextColor,
                            hourlyTemp: hourlyTemp,
                          );
                        },
                      ),
                    ),
                    Text(
                      "Today's Highlights",
                      style: TextStyle(
                        color: commonTextColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      padding: const EdgeInsets.all(16),
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        color: bgContainerColor.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          HighlightItem(
                            image: 'assets/images/highlight/pressure.png',
                            title: 'Pressure',
                            value: '$currentPressure hPa',
                          ),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.white,
                          ),
                          HighlightItem(
                            image: 'assets/images/highlight/wind.png',
                            title: 'Wind Speed',
                            value: '$currentWindSpeed m/s',
                          ),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.white,
                          ),
                          HighlightItem(
                            image: 'assets/images/highlight/humidity.png',
                            title: 'Humidity',
                            value: '$currentHumidity %',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
