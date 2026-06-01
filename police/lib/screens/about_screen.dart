import 'package:flutter/material.dart';
import 'home_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B57D0),
        foregroundColor: Colors.white,
        title: const Text("About"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(
              child: Column(
                children: [
                  Image.asset('assets/images/tn_police_logo.png', height: 100),

                  const SizedBox(height: 15),

                  const Text(
                    "Police Contacts",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Your Safety, Our Priority",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Purpose",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "Police Contacts is designed to help citizens quickly access police station contact information across Tamil Nadu. Users can search districts and police stations to find contact details of the Night Shift Officer and Primary Officer, helping them reach the right station whenever assistance is needed.",
              style: TextStyle(height: 1.6, fontSize: 15),
            ),

            const SizedBox(height: 25),

            const Text(
              "Why We Built This",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "Finding the correct police station contact during urgent situations can be difficult, especially during night hours. This application simplifies access to station-level contact information and helps citizens connect with police personnel faster.",
              style: TextStyle(height: 1.6, fontSize: 15),
            ),

            const SizedBox(height: 25),

            const Text(
              "Features",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            const FeatureTile(title: "District Search"),

            const FeatureTile(title: "Station Search"),

            const FeatureTile(title: "Night Shift Officer Details"),

            const FeatureTile(title: "Primary Officer Details"),

            const FeatureTile(title: "Favorites"),

            const SizedBox(height: 25),

            const Text(
              "Privacy",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "This application does not collect personal information from users. Location access, when enabled, is used only to identify nearby districts and improve station discovery.",
              style: TextStyle(height: 1.6, fontSize: 15),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
              ),

              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Icon(Icons.info_outline, color: Colors.orange),

                  SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      "Disclaimer: This application provides police station contact information for public convenience. In emergencies, always contact official emergency services immediately.",
                      style: TextStyle(height: 1.5),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Center(
              child: Text(
                "Version 1.0.0",
                style: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 5),

            const Center(
              child: Text(
                "Tamil Nadu Police Contact Directory",
                style: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,

        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            );
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: "About",
          ),
        ],
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  final String title;

  const FeatureTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),

          const SizedBox(width: 10),

          Text(title, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
