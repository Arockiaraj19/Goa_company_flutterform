import 'package:geocoding/geocoding.dart';

getLocName(double lat, lng) async {
  String city;
  List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    Placemark placeMark  = placemarks[0];
    city=placeMark.subAdministrativeArea;
  return city;
}