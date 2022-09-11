
import '../models/weather_model.dart';
import '../web_services/weather_web_services.dart';

class WeatherRepo {

  final WeatherWebServices weatherWebServices;

  WeatherRepo(this.weatherWebServices);

  Future<Weather> getWeather() async {
    final weather = await weatherWebServices.getCurrentWeather();
    return Weather.fromJson(weather);
  }
}