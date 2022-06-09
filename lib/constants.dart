import 'package:flutter/material.dart';

class WeatherModel {
  String background;
  Color color;

  WeatherModel({required this.background, required this.color});

  void weatherModel (dynamic weather){
    String background = '';
    late Color color;

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

    this.background = background;
    this.color = color;
  }
}

