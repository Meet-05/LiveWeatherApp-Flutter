import 'package:WeatherApp/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:WeatherApp/utilities/constants.dart';
import 'package:WeatherApp/services/weather.dart';
import 'package:WeatherApp/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weathermodel = WeatherModel();
  dynamic temperature;
  String location;
  int id;
  String weatherIcon;
  String weatherMessage;

  @override
  void initState() {
    super.initState();
    //the widget gives acces to the properties of the parent widget of state Class
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'unable to get data';
        location = '404';
        return;
      }
      try {
        dynamic temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        location = weatherData['name'];
        id = weatherData['weather'][0]['id'];
        weatherIcon = weathermodel.getWeatherIcon(id);
        weatherMessage = weathermodel.getMessage(temperature);
        print('------------------------------->$temperature');
      } catch (e) {
        print(e);
        print('erro catched');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherdata = await weathermodel.getWeatherLocation();
                      updateUI(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      //the navigator.push method  has returns  a future value i.e the valur provided bt the pop mehtod ,it is a asynchronous mehtod
                      //adn to proceed forward we require that value hence we await the execution untilwe get the value
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        var weatherdata =
                            await weathermodel.getWeatherByCity(typedName);
                        print(weatherdata);
                        updateUI(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $location',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
