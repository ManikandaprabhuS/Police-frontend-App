import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'home_screen.dart';

class DetectingLocationScreen extends StatefulWidget {
  const DetectingLocationScreen({super.key});

  @override
  State<DetectingLocationScreen> createState() =>
      _DetectingLocationScreenState();
}

class _DetectingLocationScreenState extends State<DetectingLocationScreen> {
  @override
  void initState() {
    super.initState();
    _detectLocation();
  }

  Future<void> _detectLocation() async {
    try {
      print("STEP 1 - Checking permission");

      LocationPermission permission = await Geolocator.checkPermission();

      print("Current Permission: $permission");

      if (permission == LocationPermission.denied) {
        print("STEP 2 - Requesting permission");

        permission = await Geolocator.requestPermission();

        print("Permission After Request: $permission");
      }

      if (permission == LocationPermission.deniedForever) {
        print("Permission permanently denied");
        return;
      }

      print("STEP 3 - Getting position");

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print("Latitude: ${position.latitude}");
      print("Longitude: ${position.longitude}");
      String district = "";
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        print("Placemark Count: ${placemarks.length}");

        if (placemarks.isNotEmpty) {
          district = placemarks.first.subAdministrativeArea ?? "";
          print("District: ${placemarks.first.subAdministrativeArea}");
          print("Locality: ${placemarks.first.locality}");
          print("State: ${placemarks.first.administrativeArea}");
          print("District: $district");
        }
      } catch (e) {
        print("GEOCODING ERROR: $e");
      }

      print("STEP 4 - Navigating Home");

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen(district: district)),
      );
    } catch (e) {
      print("LOCATION ERROR: $e");

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset('assets/images/tn_police_logo.png', height: 100),

            const SizedBox(height: 30),

            const Text(
              "Detecting Your Location",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            const Text(
              "Please wait while we identify your district",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
