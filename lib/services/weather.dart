import 'package:mewe/services/location.dart';
import 'package:mewe/services/networking.dart';


const api='39a07b447cec7ae09ba8c35dae696e14';
class WeatherModel {
  Future<dynamic> getCityW(String city) async
  {
    Network network =Network('http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$api&units=metric');
    var weather=await network.getData();
    return weather;

  }

  Future<dynamic> getWeather() async
  {
    Location location=Location();
    await location.getLocation();

    Network network =Network('http://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$api&units=metric');
    var weather=await network.getData();
    return weather;
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
