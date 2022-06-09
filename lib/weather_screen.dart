import 'package:flutter/material.dart';

import 'package:anim_search_bar/anim_search_bar.dart';

import 'package:kick_weather/weather_calls.dart';
import 'package:kick_weather/widgets.dart';

class WeatherScreen extends StatefulWidget {

  final dynamic weatherData;
  final String background;
  final Color colour;

  const WeatherScreen({
    Key? key,
    required this.weatherData,
    required this.background,
    required this.colour
  }) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  TextEditingController searchController = TextEditingController();
  late String cityName;
  dynamic weather;
  late Color color;

  String background = '';

  Future queryWeather (String city) async {
    return await QueryWeather(url: 'q=$city').queryWeather();
  }

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

  @override
  void initState() {
    super.initState();
    weather = widget.weatherData;
    background = widget.background;
    color = widget.colour;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size mediaQuery = MediaQuery.of(context).size;
    final double temp = weather['main']['temp'];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              background,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
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
                          closeSearchOnSuffixTap: true,

                          suffixIcon: const Icon(
                            Icons.check_outlined,
                          ),

                          onSuffixTap: () async {
                            cityName = searchController.text;

                            //query city weather
                            if(cityName.isNotEmpty){
                              weather = await queryWeather(cityName);
                              weatherModel(weather);
                            }

                            setState(() {
                              searchController.clear();

                              //close keyboard
                              FocusManager.instance.primaryFocus?.unfocus();
                            });
                          },
                        ),

                        //current location
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.gps_fixed_outlined,
                            ),

                            onPressed: (){
                              //query current weather
                              setState(() {
                                weather = widget.weatherData;
                                weatherModel(weather);
                              });
                            },
                          ),
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
                            style: TextStyle(
                              fontSize: 19.0,
                              color: color,
                            ),
                          ),

                          Text(
                            '${temp.round()}°',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 120.0,
                              letterSpacing: -10.0,
                              color: color,
                            ),
                          ),
                        ],
                      ),

                      //weather
                      RotatedBox(
                        quarterTurns: -1,
                        child: Text(
                          weather['weather'][0]['description'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: color,
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
                  color: color.withOpacity(0.05),
                  border: Border.all(
                    color: color,
                  ),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    //humidity
                    weatherDetail(
                      detail: '${weather['main']['humidity']}',
                      label: 'Humidity',
                      colour: color,
                    ),

                    //Pressure
                    weatherDetail(
                      detail: '${weather['main']['pressure']}',
                      label: 'Pressure',
                      colour: color,
                    ),

                    //Visibility
                    weatherDetail(
                      detail: '${weather['visibility']}',
                      label: 'Visibility',
                      colour: color,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
