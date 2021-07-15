import 'package:flutter/material.dart';
import 'package:mewe/location_permission.dart';
import 'package:mewe/services/weather.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // double latitude=0;
  // double longitude=0;


  @override
  void initState() {

    super.initState();
   getLocationPermission();
   getLocationData();


  }

  void getLocationData ()
  async
  {
    WeatherModel weatherModel=WeatherModel();
    var weather=await weatherModel.getWeather();
    Future.delayed(Duration(seconds: 2),()
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)
      {
        return LocationScreen(weather);
      }));
    });


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 50.0,

        ),
      ),

    );
  }
}
