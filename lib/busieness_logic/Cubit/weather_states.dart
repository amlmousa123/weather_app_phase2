import '../../data/models/weather_model.dart';

class WeatherState{}

class WeatherInitial extends WeatherState {}

class Weatherloading extends WeatherState {
}

class Weatherloaded extends WeatherState {
 final Weather weather ;

  Weatherloaded(this.weather);

}



