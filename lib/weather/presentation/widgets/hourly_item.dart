import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyItem extends StatelessWidget {
  const HourlyItem({
    required this.time,
    required this.hourlySky,
    required this.skyTextColor,
    super.key,
    this.hourlyTemp,
  });

  final DateTime time;
  final dynamic hourlyTemp;
  final String hourlySky;
  final Color skyTextColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Text(
            DateFormat('E, h a').format(time),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Text(
            hourlySky,
            style: TextStyle(
              color: skyTextColor,
              fontSize: 20,
            ),
          ),
          Image.asset(
            hourlySky == 'Clouds'
                ? 'assets/images/weather/clouds.png'
                : hourlySky == 'Rain'
                    ? 'assets/images/weather/rain.png'
                    : 'assets/images/weather/clear.png',
            width: 50,
          ),
          Text(
            '${hourlyTemp.toStringAsFixed(2)}° C',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
