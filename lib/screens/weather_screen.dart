import 'package:flutter/material.dart';

// import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'package:kick_weather/utilities/weather_calls.dart';
import 'package:kick_weather/utilities/widgets.dart';
import 'package:kick_weather/utilities/banner_adverts.dart';
import 'package:kick_weather/utilities/weather_model.dart';

class WeatherScreen extends StatefulWidget {

  final dynamic weatherData;

  const WeatherScreen({
    Key? key,
    required this.weatherData,
  }) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  // TextEditingController searchController = TextEditingController();
  bool _isBannerAdLoaded = false;
  final int _dayIndex = DateTime.now().weekday;
  late BannerAd _bannerAd;
  // late String cityName;
  late int _currDay;
  dynamic _weather;

  final Map<int, String> _days = const {
    1: 'Mon',
    2: 'Tue',
    3: 'Wed',
    4: 'Thu',
    5: 'Fri',
    6: 'Sat',
    7: 'Sun',
  };

  int _dayEval (int day){

    if((_dayIndex+day) > 7){
      _currDay += 1;
      return _currDay;
    }
    else {
      _currDay = 0;
      return _dayIndex+day;
    }
  }

  // Future queryWeather (String city) async {
  //   return await QueryWeather(url: 'q=$city').queryWeather();
  // }

  void _bottomBannerAd (){
    _bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: BannerAdverts.bannerAdUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_){
          setState(() {
            _isBannerAdLoaded = true;
          });
        },

        onAdFailedToLoad: (ad, error){
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    _weather = widget.weatherData;
    _currDay = 0;
    _bottomBannerAd();
  }

  @override
  void dispose() {
    // searchController.dispose();
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size mediaQuery = MediaQuery.of(context).size;

    Color colour = Provider.of<WeatherModel>(context, listen: true).colour;
    String background = Provider.of<WeatherModel>(context, listen: true).background;
    // WeatherModel weathermodel = Provider.of<WeatherModel>(context, listen: false);

    return Scaffold(
      bottomNavigationBar: _isBannerAdLoaded ?
      SizedBox(
        height: _bannerAd.size.height.toDouble(),
        width: _bannerAd.size.width.toDouble(),

        child: AdWidget(
          ad: _bannerAd,
        ),
      ) : null,

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
            top: mediaQuery.height * 0.15,
            left: mediaQuery.width * 0.06,
            right: mediaQuery.width * 0.09,
            bottom: mediaQuery.height * 0.04,
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Column(
                children: [
                  //search city and locate current

                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     bottom: 8.0,
                  //   ),
                  //
                  //   //current + city search
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //
                  //     children: [
                  //
                  //       //search city
                  //       AnimSearchBar(
                  //         width: mediaQuery.width * 0.72,
                  //         textController: searchController,
                  //         helpText: 'Search City',
                  //         closeSearchOnSuffixTap: true,
                  //
                  //         suffixIcon: const Icon(
                  //           Icons.check_outlined,
                  //         ),
                  //
                  //         onSuffixTap: () async {
                  //           cityName = searchController.text;
                  //
                  //           //query city weather
                  //           if(cityName.isNotEmpty){
                  //             weather = await queryWeather(cityName);
                  //             weathermodel.weatherModel(weather);
                  //           }
                  //
                  //           setState(() {
                  //             searchController.clear();
                  //
                  //             //close keyboard
                  //             FocusManager.instance.primaryFocus?.unfocus();
                  //           });
                  //         },
                  //       ),
                  //
                  //       //current location
                  //       Container(
                  //         decoration: const BoxDecoration(
                  //           color: Colors.white,
                  //           shape: BoxShape.circle,
                  //         ),
                  //         child: IconButton(
                  //           icon: const Icon(
                  //             Icons.gps_fixed_outlined,
                  //           ),
                  //
                  //           onPressed: (){
                  //             //query current weather
                  //             // setState(() {
                  //             //   weather = widget.weatherData;
                  //             //   weathermodel.weatherModel(weather);
                  //             // });
                  //           },
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  //city, temperature and weather
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      //city and temp
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            _weather['timezone'],
                            style: TextStyle(
                              fontSize: 19.0,
                              color: colour,
                            ),
                          ),

                          Text(
                            '${_weather['current']['temp'].round()}°',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 120.0,
                              letterSpacing: -10.0,
                              color: colour,
                            ),
                          ),
                        ],
                      ),

                      //weather
                      RotatedBox(
                        quarterTurns: -1,
                        child: Text(
                          _weather['current']['weather'][0]['description'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: colour,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              //weather details
              Container(
                height: mediaQuery.height * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: colour.withOpacity(0.05),
                  border: Border.all(
                    color: colour,
                  ),
                ),

                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      weatherForecast(
                        day: '${_days[_dayIndex]}',
                        temp: '${_weather['current']['temp']}°',
                        humidity: 'Humidity - ${_weather['current']['humidity']}',
                        pressure: 'Pressure - ${_weather['current']['pressure']}',
                        colour: colour.withOpacity(0.05),
                      ),

                      weatherForecast(
                        day: '${_days[_dayEval(1)]}',
                        temp: '${_weather['daily'][0]['temp']['day'].round()}°',
                        humidity: 'Humidity - ${_weather['daily'][0]['humidity']}',
                        pressure: 'Pressure - ${_weather['daily'][0]['pressure']}',
                        colour: colour.withOpacity(0.05),
                      ),

                      weatherForecast(
                        day: '${_days[_dayEval(2)]}',
                        temp: '${_weather['daily'][1]['temp']['day'].round()}°',
                        humidity: 'Humidity - ${_weather['daily'][1]['humidity']}',
                        pressure: 'Pressure - ${_weather['daily'][1]['pressure']}',
                        colour: colour.withOpacity(0.05),
                      ),

                      weatherForecast(
                        day: '${_days[_dayEval(3)]}',
                        temp: '${_weather['daily'][2]['temp']['day'].round()}°',
                        humidity: 'Humidity - ${_weather['daily'][2]['humidity']}',
                        pressure: 'Pressure - ${_weather['daily'][2]['pressure']}',
                        colour: colour.withOpacity(0.05),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
