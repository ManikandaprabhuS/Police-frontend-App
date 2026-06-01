import 'package:flutter/material.dart';
import 'location_permission_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  double opacity = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        setState(() {
          opacity = 1;
        });
      },
    );

    Future.delayed(
      const Duration(seconds: 4),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const LocationPermissionScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF001F54),
              Color(0xFF003366),
            ],
          ),
        ),

        child: Center(
          child: AnimatedOpacity(
            opacity: opacity,
            duration:
                const Duration(seconds: 2),

            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [

                Image.asset(
                  'assets/images/tn_police_logo.png',
                  height: 150,
                ),

                const SizedBox(height: 20),

                const Text(
                  "Tamil Nadu Police",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Your Safety, Our Priority",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}