import 'package:flutter/material.dart';

import 'package:WeatherApp/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:WeatherApp/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  //This method is called whenever the stateful widget is added i the widget tree
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    var weatherData = await WeatherModel().getWeatherLocation();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitChasingDots(
        color: Colors.blue,
        size: 90,
      )),
    );
  }
}
