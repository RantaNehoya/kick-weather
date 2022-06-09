import 'package:flutter/material.dart';

import 'package:anim_search_bar/anim_search_bar.dart';

import 'package:kick_weather/weather_calls.dart';

class WeatherScreen extends StatefulWidget {

  final dynamic weatherData;
  const WeatherScreen({Key? key, required this.weatherData}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  TextEditingController searchController = TextEditingController();
  late String cityName;

  Future queryWeather () async {
    return await QueryWeather(url: 'q=$cityName').queryWeather();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size mediaQuery = MediaQuery.of(context).size;
    dynamic weather = widget.weatherData;
    final double temp = weather['main']['temp'];

    return Scaffold(
      //TODO:BACKGROUND IMAGE
      body: Padding(
        padding: EdgeInsets.only(
          top: mediaQuery.height * 0.06,
          left: mediaQuery.width * 0.06,
          right: mediaQuery.width * 0.09,
          bottom: mediaQuery.height * 0.04,
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                  ),

                  //current + city search
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [

                      //search city
                      AnimSearchBar(
                        width: mediaQuery.width * 0.72,
                        textController: searchController,
                        helpText: 'Search City',

                        suffixIcon: const Icon(
                          Icons.check_outlined,
                        ),

                        onSuffixTap: () async {
                          cityName = searchController.text;

                          //query city weather
                          weather = await queryWeather();

                          setState(() {
                            searchController.clear();
                          });

                          //close keyboard
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),

                      //current location
                      IconButton(
                        icon: const Icon(
                          Icons.gps_fixed_outlined,
                        ),

                        onPressed: (){
                          //query current weather
                          setState(() {
                            weather = widget.weatherData;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                //city, temperature and weather
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //city and temp
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          weather['name'],
                          style: const TextStyle(
                            fontSize: 19.0,
                          ),
                        ),

                        Text(
                          '${temp.round()}°',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 120.0,
                            letterSpacing: -12.0,
                          ),
                        ),
                      ],
                    ),

                    //weather
                    RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        weather['weather'][0]['description'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            //weather details
            Container(
              height: mediaQuery.height * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black.withOpacity(0.05),
                border: Border.all(
                  color: Colors.black,
                ),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  //humidity
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${weather['main']['humidity']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Text(
                        'Humidity',
                      ),
                    ],
                  ),

                  //Pressure
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${weather['main']['pressure']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Text(
                        'Pressure',
                      ),
                    ],
                  ),

                  //Visibility
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${weather['visibility']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Text(
                        'Visibility',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
