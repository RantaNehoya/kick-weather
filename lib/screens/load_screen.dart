import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'package:kick_weather/screens/weather_screen.dart';
import 'package:kick_weather/utilities/weather_calls.dart';
import 'package:kick_weather/utilities/weather_model.dart';

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
    Provider.of<WeatherModel>(context, listen: false).weatherModel(data);

    Navigator.push(
      context, MaterialPageRoute(builder: (context) => WeatherScreen(
      weatherData: data,
    ),
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
    return Scaffold(
      backgroundColor: Color(0xFF131313),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpinKitChasingDots(
            color: Colors.white70,
            size: 70.0,
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),

          const Text(
            'KickWeather',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
