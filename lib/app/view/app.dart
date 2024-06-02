import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:learn_bloc/time/bloc/time_bloc.dart';

import 'package:learn_bloc/weather/bloc/weather_bloc.dart';
import 'package:learn_bloc/weather/data/data_provider/weather_data_provider.dart';
import 'package:learn_bloc/weather/data/repository/weather_repository.dart';

import 'package:learn_bloc/weather/presentation/screens/weather_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => WeatherRepository(WeatherDataProvider()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WeatherBloc(
              context.read<WeatherRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => TimeBloc(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            useMaterial3: true,
            textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Bearskin',
                ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          home: const WeatherScreen(),
        ),
      ),
    );
  }
}
