import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_frontend/domain/activity_repository/activity_repository.dart';
import 'package:weather_frontend/domain/weather_repository/src/weather_repository.dart';
import 'package:weather_frontend/feature/activity/cubit/activity_cubit.dart';
import 'package:weather_frontend/feature/search/search.dart';
import 'package:weather_frontend/feature/settings/settings.dart';
import 'package:weather_frontend/feature/theme/theme.dart';
import 'package:weather_frontend/feature/weather/weather.dart';

import '../widgets/weather_list_populated.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => WeatherCubit(
            context.read<WeatherRepository>(),
          ),
        ),
        BlocProvider(
          create: (_) => ActivityCubit(context.read<ActivityRepository>()),
        ),
      ],
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push<void>(
                SettingsPage.route(
                  context.read<WeatherCubit>(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              // context.read<ThemeCubit>().updateTheme(state.weather);
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case WeatherStatus.initial:
                return const WeatherEmpty();
              case WeatherStatus.loading:
                return const WeatherLoading();
              case WeatherStatus.success:
                // return WeatherPopulated(
                //   weather: state.weather,
                //   // units: state.degreeUnits,
                //   onRefresh: () {
                //     return context.read<WeatherCubit>().refreshWeather();
                //   },
                // );
                return WeatherListPopulated(
                  weatherList: state.weatherList,
                  // units: state.degreeUnits,
                );
              case WeatherStatus.failure:
                return const WeatherError();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search, semanticLabel: 'Search'),
        onPressed: () async {
          final city = await Navigator.of(context).push(SearchPage.route());
          if (!mounted) return;
          // await context.read<WeatherCubit>().fetchWeather(city);
          await context.read<WeatherCubit>().fetchWeatherList(city!);
        },
      ),
    );
  }
}
