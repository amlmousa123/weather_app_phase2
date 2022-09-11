import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_phase2/presentation/home.dart';

import 'busieness_logic/Cubit/weather_cubit.dart';
import 'data/repository/weather_repository.dart';
import 'data/web_services/weather_web_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
          create: (BuildContext context) =>
              WeatherCubit(WeatherRepo(WeatherWebServices())),
          child: Home()),
    );
  }
}
