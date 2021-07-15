import 'package:flutter/material.dart';
import 'package:mewe/utilities/constants.dart';
import 'package:mewe/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.weatherLocation);
  final weatherLocation;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {  
  WeatherModel weatherC=WeatherModel();
  var temperature;
  var city;
  String icon='';
  String message='';
  @override
  void initState() {
    super.initState();
    update(widget.weatherLocation);

  }

  void update(dynamic weather){

    setState(() {
      if(weather==null)
      {
        temperature=0;
        city='';
        icon='Error';
        message='Unable to get data';
        return;

      }


    double temp=weather['main']['temp'];
    temperature=temp.toInt();
    city=weather['name'];
    var condition=weather['weather'][0]['id'];
    icon=weatherC.getWeatherIcon(condition);
    message=weatherC.getMessage(temperature);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('images/location_background.jpg'),
        //     fit: BoxFit.cover,
        //     colorFilter: ColorFilter.mode(
        //         Colors.white.withOpacity(0.8), BlendMode.dstATop),
        //   ),
        // ),
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
                    onPressed: () async{
                      var weatherU=await weatherC.getWeather();
                      update(weatherU);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                     var typed=await Navigator.push(context, MaterialPageRoute(builder: (context)
                      {
                        return CityScreen();
                      }));
                     if(typed!=null)
                       {
                         var citydata=await weatherC.getCityW(typed);
                         update(citydata);
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
                      icon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $city!',
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
