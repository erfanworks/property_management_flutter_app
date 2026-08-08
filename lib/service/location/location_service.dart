// import 'package:geolocator/geolocator.dart';
//
// class LocationService {
//   LocationService._();
//   static final LocationService instance = LocationService._();
//
//   // ─── Default fallback (London) ────────────
//   static const double defaultLat = 51.5074;
//   static const double defaultLng = -0.1278;
//
//   double _lat = defaultLat;
//   double _lng = defaultLng;
//
//   double get lat => _lat;
//   double get lng => _lng;
//
//   Future<void> init() async {
//     try {
//       final permission = await _checkPermission();
//       if (!permission) return;
//
//       final position = await Geolocator.getCurrentPosition(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.low,
//           timeLimit: Duration(seconds: 5),
//         ),
//       );
//
//       _lat = position.latitude;
//       _lng = position.longitude;
//     } catch (_) {
//       // fallback to default
//     }
//   }
//
//   Future<bool> _checkPermission() async {
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) return false;
//
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) return false;
//       }
//
//       if (permission == LocationPermission.deniedForever) return false;
//
//       return true;
//     } catch (_) {
//       return false;
//     }
//   }
// }