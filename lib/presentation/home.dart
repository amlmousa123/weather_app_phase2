
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:intl/intl.dart';

import '../busieness_logic/Cubit/weather_cubit.dart';
import '../busieness_logic/Cubit/weather_states.dart';
import '../data/models/weather_model.dart';
import '../data/repository/weather_repository.dart';
import '../data/web_services/weather_web_services.dart';
import 'detailPage.dart';
import 'extraWeather.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Weather weather;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherCubit>(context).getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Color(0xff030317),
          child: BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              if (state is Weatherloaded) {
                weather = (state).weather;
                return Column(
                  children: [
                    CurrentWeather(currentWeather: weather),
                    TodayWeather(forecostWeather: weather,)
                  ],
                );
              }
              return Container();
            },
          )),
    );
  }
}

class CurrentWeather extends StatelessWidget {
  final Weather currentWeather;

  const CurrentWeather({super.key, required this.currentWeather});
  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      height: 450,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.only(top: 50, left: 30, right: 30),
      glowColor: Color(0xff00A1FF).withOpacity(0.5),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      color: Color(0xff00A1FF),
      spreadRadius: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            currentWeather.location.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Container(
            height: 250,
            child: Stack(
              children: [
                Image.asset(
                  'assets/sunny.png',
                  fit: BoxFit.fill,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Center(
                      child: Column(
                    children: [
                      GlowText(
                        currentWeather.current.tempC.toString() + '°',
                        style: TextStyle(
                            height: 0.1,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                          currentWeather.forecast.forecastday[0].day.maxtempC
                                  .toString() +
                              '°' +
                              ' / ' +
                              currentWeather
                                  .forecast.forecastday[0].day.mintempC
                                  .toString() +
                              '°',
                          style: TextStyle(
                            fontSize: 25,
                          )),
                      Text(
                         'SAT'+ DateFormat(" hh:mm ").format(DateTime.parse(
                              currentWeather.location.localtime)),
                          style: TextStyle(
                            fontSize: 18,
                          ))
                    ],
                  )),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          ExtraWeather(currentWeather)
        ],
      ),
    );
  }
}

class TodayWeather extends StatelessWidget {
  final Weather forecostWeather;

  const TodayWeather({super.key, required this.forecostWeather});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold ,color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return DetailPage(forecastSevenDays: forecostWeather);
                      }));
                },
                child: Row(
                  children: [
                    Text(
                      "7 days ",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                      size: 15,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 30,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                forecostWeather.forecast.forecastday[0].hour.map((hour) => WeatherWidget(hour: hour)).toList()
                ,
              ),
            )
              ),
        ],
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  final Hour hour;

  const WeatherWidget({super.key, required this.hour});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(width: 0.2, color: Colors.white),
          borderRadius: BorderRadius.circular(35)),
      child: Column(
        children: [
          Text(
            hour.tempC.toString() + "°",
            style: TextStyle(fontSize: 20,color: Colors.white),
          ),
          SizedBox(
            height: 5,
          ),
            Container(
              width: 50,
              height: 50,
              child: Image.asset(
                'assets/sunny_2d.png',
                fit: BoxFit.fill,
              ),
            ),

          SizedBox(
            height: 5,
          ),
          Text(
            DateFormat("hh").format(DateTime.parse(
                hour.time)),
            style: TextStyle(fontSize: 16, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
