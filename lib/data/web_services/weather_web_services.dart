import 'package:dio/dio.dart';

import '../../constants/strings.dart';

class WeatherWebServices {
  late Dio dio;

  WeatherWebServices() {
    BaseOptions options = BaseOptions(
        baseUrl: baseURL,
        receiveDataWhenStatusError: true,
        receiveTimeout: 20 * 1000,
        connectTimeout: 20 * 1000);
    dio = Dio(options);
  }

  Future<dynamic> getCurrentWeather() async {
    try {
      Response response = await dio.get(
          'forecast.json?key=b46be8b332eb46dabd4232808220709&q=Cairo&days=7&aqi=no&alerts=no');
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e);
      return ;
    }
  }
}
