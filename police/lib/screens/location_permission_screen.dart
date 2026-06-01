import 'package:flutter/material.dart';
import 'detecting_location_screen.dart';
import 'home_screen.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              Image.asset(
                'assets/images/tn_police_logo.png',
                height: 100,
              ),

              const SizedBox(height: 20),

              Stack(
                alignment: Alignment.center,
                children: [

                  Container(
                    width: 160,
                    height: 160,

                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                  ),

                  const Icon(
                    Icons.location_on,
                    size: 80,
                    color: Color(0xFF2563EB),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Allow Location Access",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                "We use your location to automatically identify your district and show nearby police station contacts.",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius:
                      BorderRadius.circular(16),
                ),

                child: const Row(
                  children: [

                    Icon(
                      Icons.security_outlined,
                      color: Colors.blue,
                    ),

                    SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        "Your location is only used to identify your district and will never be stored or shared.",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton.icon(
                  onPressed: () {

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const DetectingLocationScreen(),
                      ),
                    );

                  },

                  icon: const Icon(
                    Icons.navigation,
                    color: Colors.white,
                  ),

                  label: const Text(
                    "Allow Location Access",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF2563EB),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () {

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const HomeScreen(),
                    ),
                  );

                },

                child: const Text(
                  "Continue Without Location",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}