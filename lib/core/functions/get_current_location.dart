import 'package:geolocator/geolocator.dart';


class GetCurrentLocation {
  // return user current location
  Future<Position?> getCurrentLocation() async {
    try {
      // req permission to access the device's location
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // If permission is denied then return null
        return null;
      }
      // if permission is allowed
      return await Geolocator.getCurrentPosition(
        //this is to get user current position using Geolocator package
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }
}
