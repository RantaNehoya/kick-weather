import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class QueryWeather {
  final String url;

  final apiKey = 'c244c1654d84b66db6f88282873dc501';

  QueryWeather({required this.url});

  Future queryWeather () async {

    http.Response response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?$url&appid=$apiKey&units=metric'),
    );

    if(response.statusCode == 200) {

      dynamic decodedResponse = jsonDecode(response.body);
      return decodedResponse;

    }
    else {
      throw 'Error getting weather';
    }
  }
}

class WeatherApi {

  Future getCurrentLocation () async {
    LocationPermission permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied || permission == LocationPermission.unableToDetermine){
      await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    dynamic data = await QueryWeather(
      url: 'lat=${position.latitude}&lon=${position.longitude}',
    ).queryWeather();

    return data;
  }
}