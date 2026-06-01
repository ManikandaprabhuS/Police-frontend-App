import 'package:flutter/material.dart';
import 'station_list_screen.dart';
import 'district_list_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,

        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AboutScreen()),
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

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 10),

                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/tn_police_logo.png',
                        height: 80,
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Police Contacts",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        "Your Safety, Our Priority",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                TextField(
                  decoration: InputDecoration(
                    hintText: "Search district or station",
                    prefixIcon: const Icon(Icons.search),

                    filled: true,
                    fillColor: Colors.grey.shade100,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      "Browse by District",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DistrictListScreen(),
                          ),
                        );
                      },

                      child: const Text(
                        "View All",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.5,

                  children: const [
                    DistrictCard(district: "Chennai"),

                    DistrictCard(district: "Coimbatore"),

                    DistrictCard(district: "Madurai"),

                    DistrictCard(district: "Salem"),

                    DistrictCard(district: "Trichy"),

                    DistrictCard(district: "Tirunelveli"),
                  ],
                ),

                const SizedBox(height: 25),

                Container(
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: const Row(
                    children: [
                      Icon(Icons.phone, color: Colors.blue),

                      SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              "Emergency?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            SizedBox(height: 5),

                            Text(
                              "Call 100",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DistrictCard extends StatelessWidget {
  final String district;

  const DistrictCard({super.key, required this.district});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StationListScreen(district: district),
          ),
        );
      },

      borderRadius: BorderRadius.circular(16),

      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,

          borderRadius: BorderRadius.circular(16),

          border: Border.all(color: Colors.grey.shade200),
        ),

        child: Padding(
          padding: const EdgeInsets.all(12),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Icon(Icons.location_city, color: Colors.blue),

              const SizedBox(height: 10),

              Text(
                district,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 3),

              const Text(
                "Police Stations",
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
