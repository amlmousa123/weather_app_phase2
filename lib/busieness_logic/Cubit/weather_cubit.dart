
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_phase2/busieness_logic/Cubit/weather_states.dart';

import '../../data/models/weather_model.dart';
import '../../data/repository/weather_repository.dart';

class WeatherCubit extends Cubit<WeatherState>{
 final WeatherRepo weatherRepository ;
  Weather weather = Weather();

 WeatherCubit(this.weatherRepository) : super(WeatherInitial());
  Weather getWeather ()  {
    weatherRepository.getWeather().then((weather){
      emit(Weatherloaded(weather));
      this.weather = weather ;
    });
    return weather ;

  }

  }