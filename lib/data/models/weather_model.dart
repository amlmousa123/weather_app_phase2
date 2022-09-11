class Weather {
  late final Location location;
  late final Current current;
  late final Forecast forecast;

  Weather();

  Weather.fromJson(Map<String, dynamic> json) {
    location = Location.fromJson(json['location']);
    current = Current.fromJson(json['current']);
    forecast = Forecast.fromJson(json['forecast']);
  }
}

class Location {
  late final String name;
  late final double lat;
  late final double lon;
  late final String localtime;

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lat = json['lat'];
    lon = json['lon'];
    localtime = json['localtime'];
  }
}

class Current {
  late final double tempC;
  late final Condition condition;
  late final double windKph;
  late final int humidity;
  late final double feelslikeC;
  late final double uv;

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    condition = Condition.fromJson(json['condition']);
    windKph = json['wind_kph'];
    humidity = json['humidity'];
    feelslikeC = json['feelslike_c'];
    uv = json['uv'];
  }

}

class Condition {
  late final String text;
  late final String icon;

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
  }
}

class Forecast {

  late final List<Forecastday> forecastday;

  Forecast.fromJson(Map<String, dynamic> json) {
    forecastday = List.from(json['forecastday'])
        .map((e) => Forecastday.fromJson(e))
        .toList();
  }
}
class Forecastday {

  late final String date;
  late final Day day;
  late final Astro astro;
  late final List<Hour> hour;

  Forecastday.fromJson(Map<String, dynamic> json){
    date = json['date'];
    day = Day.fromJson(json['day']);
    astro = Astro.fromJson(json['astro']);
    hour = List.from(json['hour']).map((e) => Hour.fromJson(e)).toList();
  }
}

class Day {
  late final double maxtempC;
  late final double? mintempC;
  late final Condition condition;
  late final int dailyChanceOfRain ;
  Day.fromJson(Map<String, dynamic> json){
    maxtempC = json['maxtemp_c'];
    mintempC = json['mintemp_c'];
    condition = Condition.fromJson(json['condition']);
    dailyChanceOfRain = json['daily_chance_of_rain'];


  }
}

class Astro {
  late final String sunrise;
  late final String sunset;

  Astro.fromJson(Map<String, dynamic> json){
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
}

class Hour {
  late final String time;
  late final double? tempC;
  late final Condition condition;
  late final int chanceOfRain;

  Hour.fromJson(Map<String, dynamic> json){
    time = json['time'];
    tempC = json['temp_c'];
    condition = Condition.fromJson(json['condition']);
    chanceOfRain = json['chance_of_rain'];
  }
}


