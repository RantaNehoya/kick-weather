import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'package:kick_weather/screens/load_screen.dart';
import 'package:kick_weather/utilities/weather_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherModel(),
      child: const MaterialApp(
        title: 'KickWeather',
        debugShowCheckedModeBanner: false,
        home: LoadScreen(),
      ),
    );
  }
}
