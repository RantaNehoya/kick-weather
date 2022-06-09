import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  String background = '';
  late Color color;

  dynamic getWeather () async {
    return await weather.getCurrentLocation();
  }

  //TODO
  void weatherModel (dynamic weather){
    int id = weather['weather'][0]['id'];

    if (id > 800){
      //Clouds
      background = 'assets/images/cloudy.jpg';
      color = Colors.black;
    }
    else if (id == 800){
      //clear sky
      background = 'assets/images/clear_sky.jpg';
      color = Colors.white70;
    }
    else if (id >= 700){
      //Atmosphere
      background = 'assets/images/atmosphere.jpg';
      color = Colors.black;
    }
    else if (id >= 600){
      //Snow
      background = 'assets/images/snow.jpg';
      color = Colors.black;
    }
    else if (id >= 500){
      //Rain
      background = 'assets/images/rain.jpg';
      color = Colors.white70;
    }
    else if (id >= 300){
      //Drizzle
      background = 'assets/images/drizzle.jpg';
      color = Colors.white70;
    }
    else if (id >= 200){
      //Thunderstorm
      background = 'assets/images/thunderstorm.png';
      color = Colors.white70;
    }
  }

  void newScreen() async {
    data = await getWeather();
    weatherModel(data);

    Navigator.push(
      context, MaterialPageRoute(builder: (context) => WeatherScreen(
      weatherData: data,
      background: background,
      colour: color,
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
    return const Scaffold(
      backgroundColor: Color(0xFF131313),
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.white70,
          size: 70.0,
        ),
      ),
    );
  }
}
