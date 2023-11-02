import 'package:geolocator/geolocator.dart';

class LocationLib {
  Future<void> checkPermission() async {
    final LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.deniedForever) {
        await Geolocator.openLocationSettings();
        return;
      }
    } else if (locationPermission == LocationPermission.deniedForever) {
      await Geolocator.openLocationSettings();
      return;
    }
  }

  Future<bool> locationServiceEnabled() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return false;
    }
    return true;
  }

  Future<Position> getCurrentLocation() async {
    await checkPermission();
    if (await locationServiceEnabled() == false) {
      return Future.error('Location service is not enabled');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }
}
