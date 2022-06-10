import 'package:flutter/material.dart';

class WeatherModel with ChangeNotifier {

  late String _background;
  late Color _colour;

  //background getter
  String get background => _background;

  //colour getter
  Color get colour => _colour;

  //change background and colour
  void changeBackgroundandColour ({required String bg, required Color c}){
    _background = bg;
    _colour = c;
    notifyListeners();
  }

  void weatherModel (dynamic weather){

    int id = weather['current']['weather'][0]['id'];

    if (id > 800){
      //Clouds
      changeBackgroundandColour(
        bg: 'assets/images/cloudy.jpg',
        c: Colors.black,
      );
    }
    else if (id == 800){
      //clear sky
      changeBackgroundandColour(
        bg: 'assets/images/clear_sky.jpg',
        c: Colors.white70,
      );
    }
    else if (id >= 700){
      //Atmosphere
      changeBackgroundandColour(
        bg: 'assets/images/atmosphere.jpg',
        c: Colors.black,
      );
    }
    else if (id >= 600){
      //Snow
      changeBackgroundandColour(
        bg: 'assets/images/snow.jpg',
        c: Colors.black,
      );
    }
    else if (id >= 500){
      //Rain
      changeBackgroundandColour(
        bg: 'assets/images/rain.jpg',
        c: Colors.white70,
      );
    }
    else if (id >= 300){
      //Drizzle
      changeBackgroundandColour(
        bg: 'assets/images/drizzle.jpg',
        c: Colors.white70,
      );
    }
    else if (id >= 200){
      //Thunderstorm
      changeBackgroundandColour(
        bg: 'assets/images/thunderstorm.png',
        c: Colors.white70,
      );
    }
  }
}
