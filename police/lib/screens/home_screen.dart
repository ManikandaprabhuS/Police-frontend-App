import 'package:flutter/material.dart';
import 'station_list_screen.dart';
import 'district_list_screen.dart';
import 'about_screen.dart';
import '../services/api_service.dart';
import 'station_details_screen.dart';

class HomeScreen extends StatefulWidget {
  final String district;

  const HomeScreen({super.key, this.district = ""});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  List<dynamic> districts = [];
  List<dynamic> stations = [];

  bool isLoading = true;
  String searchText = "";

  List<dynamic> get filteredDistricts {
    return districts.where((district) {
      return district["districtName"].toString().toLowerCase().contains(
        searchText.toLowerCase(),
      );
    }).toList();
  }

  List<dynamic> get filteredStations {
    return stations.where((station) {
      return station["stationName"].toString().toLowerCase().contains(
        searchText.toLowerCase(),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final districtData = await ApiService.getDistricts();

      final stationData = await ApiService.getStations();

      setState(() {
        districts = districtData;
        stations = stationData;
        isLoading = false;
      });
    } catch (e) {
      print("HOME API ERROR: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
  return Scaffold(
    backgroundColor: Colors.white,

    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Image.asset(
              'assets/images/tn_police_logo.png',
              height: 100,
            ),

            const SizedBox(height: 30),

            const CircularProgressIndicator(),

            const SizedBox(height: 25),

            const Text(
              "Loading Police Directory",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Fetching districts and station records from server...",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Please wait a few seconds",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,

        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          }

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

                // Container(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 12,
                //     vertical: 10,
                //   ),
                //   decoration: BoxDecoration(
                //     color: Colors.blue.shade50,
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: Row(
                //     children: [
                //       const Icon(
                //         Icons.location_on,
                //         color: Colors.red,
                //       ),

                //       const SizedBox(width: 8),

                //       Expanded(
                //         child: Text(
                //           district.isEmpty
                //               ? "Location: Not Selected"
                //               : district,
                //           style: const TextStyle(
                //             fontWeight: FontWeight.w600,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 20),

                TextField(
                  controller: searchController,

                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },

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
                if (searchText.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),

                    child: Column(
                      children: [
                        if (filteredDistricts.isEmpty &&
                            filteredStations.isEmpty)
                          const ListTile(title: Text("No results found")),
                        ...filteredDistricts.map(
                          (district) => ListTile(
                            leading: const Icon(
                              Icons.location_city,
                              color: Colors.blue,
                            ),

                            title: Text(district["districtName"]),

                            subtitle: const Text("District"),

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => StationListScreen(
                                    districtId: district["_id"],
                                    district: district["districtName"],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        ...filteredStations.map(
                          (station) => ListTile(
                            leading: const Icon(
                              Icons.local_police,
                              color: Colors.green,
                            ),

                            title: Text(station["stationName"]),

                            subtitle: Text(
                              station["districtId"]?["districtName"] ?? "",
                            ),

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => StationDetailsScreen(
                                    stationId: station["_id"],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

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
                            builder: (_) => const DistrictListScreen(),
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

                  children: districts
                      .take(6)
                      .map(
                        (district) => DistrictCard(
                          districtId: district["_id"],
                          district: district["districtName"],
                        ),
                      )
                      .toList(),
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
  final String districtId;

  const DistrictCard({
    super.key,
    required this.district,
    required this.districtId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                StationListScreen(districtId: districtId, district: district),
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
