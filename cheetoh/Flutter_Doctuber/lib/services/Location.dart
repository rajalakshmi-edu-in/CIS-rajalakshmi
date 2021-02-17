import 'package:geolocator/geolocator.dart' as geolocator;

class Location {
  double kLatitude;
  double kLongitude;

  // ignore: missing_return
  Future<Location> getCurrentLocation() async {
    try {
      geolocator.Position kPosition = await geolocator.Geolocator()
          .getCurrentPosition(
              desiredAccuracy: geolocator.LocationAccuracy.best);

      location.kLatitude = kPosition.latitude;
      location.kLongitude = kPosition.longitude;

      return location;
    } catch (e) {
      print(e.toString());
    }
  }
}

Location location = new Location();
