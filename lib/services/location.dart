import 'package:geolocator/geolocator.dart';

class Location
{
  double latitude=0;
  double longitude=0;

  Future<void> getLocation()async
  {
    try{
  print('getting location');
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  latitude=position.latitude;
  longitude=position.longitude;

  }
  catch(e)
  {
    print(e);
  }

}

}
