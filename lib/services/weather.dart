import 'package:WeatherApp/services/location.dart';
import 'package:WeatherApp/services/networking.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final key = DotEnv().env['API_KEY'];
const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getWeatherByCity(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        url: '$baseUrl?q=$cityName&units=metric&appid=$key&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherLocation() async {
    Location location = Location();
    await location
        .getLocation(); //we use await keyword to block the execution unitl we get a real response.Or else the two print statements will print null.
    NetworkHelper networkHelper = NetworkHelper(
        url:
            '$baseUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$key&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
