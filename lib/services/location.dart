import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  //since this method is asynchronous ,the return type is Future.
  Future<void> getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
  }
}
