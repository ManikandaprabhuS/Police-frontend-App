import 'package:flutter/material.dart';

class DetectingLocationScreen extends StatelessWidget {
  const DetectingLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Image.asset(
              'assets/images/tn_police_logo.png',
              height: 100,
            ),

            const SizedBox(height: 30),

            const Text(
              "Detecting Your Location",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
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