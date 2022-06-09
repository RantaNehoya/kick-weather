import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kick_weather/weather_calls.dart';
import 'package:kick_weather/weather_screen.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({Key? key}) : super(key: key);

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  WeatherApi weather = WeatherApi();
  late dynamic data;

  void newScreen() async {
    data = await weather.getCurrentLocation();
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => WeatherScreen(weatherData: data),
    ),
    );
  }

  @override
  void initState() {
    newScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.black,
        ),
      ),
    );
  }
}
