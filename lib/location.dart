import 'package:geolocator/geolocator.dart';

Future<Location> fetchLocation() async {
  Geolocator geolocator = new Geolocator();
  final Position position = await geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
  List<Placemark> placemark = await Geolocator()
      .placemarkFromCoordinates(position.latitude, position.longitude);
  final Placemark place = placemark[0];

  if ((position.latitude != null) &&
      (position.longitude != null) &&
      (place.name != null)) {
    return Location.fromGeoLocationData(position, place);
  } else {
    throw Exception('Failed to get location!');
  }
}

class Location {
  double currentLatitude;
  double currentLongitude;

  Location({
    this.currentLatitude,
    this.currentLongitude,
  });

  factory Location.fromGeoLocationData(
      Position position, Placemark place) {
    return Location(
      currentLatitude: position.latitude,
      currentLongitude: position.longitude,
    );
  }
}
