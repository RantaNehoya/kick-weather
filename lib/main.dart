import 'package:flutter/material.dart';
import 'package:kick_weather/search_city_screen.dart';
import 'package:kick_weather/weather_screen.dart';

import 'load_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoadScreen(),
    );
  }
}
