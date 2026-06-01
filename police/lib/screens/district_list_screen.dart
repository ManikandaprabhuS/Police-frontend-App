import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'station_list_screen.dart';
import 'about_screen.dart';

class DistrictListScreen extends StatefulWidget {
   const DistrictListScreen({super.key});

  @override
  State<DistrictListScreen> createState() =>
      _DistrictListScreenState();
}

class _DistrictListScreenState
    extends State<DistrictListScreen> {

  final TextEditingController searchController =
      TextEditingController();

  final List<Map<String, dynamic>> districts = [
    {"name": "Chennai", "stations": 38},
    {"name": "Coimbatore", "stations": 42},
    {"name": "Madurai", "stations": 31},
    {"name": "Salem", "stations": 28},
    {"name": "Trichy", "stations": 35},
    {"name": "Tirunelveli", "stations": 26},
    {"name": "Erode", "stations": 20},
    {"name": "Vellore", "stations": 24},
    {"name": "Thanjavur", "stations": 19},
    {"name": "Kanyakumari", "stations": 18},
  ];

  String searchText = "";

  @override
  Widget build(BuildContext context) {

    final filteredDistricts = districts
        .where(
          (district) => district["name"]
              .toString()
              .toLowerCase()
              .contains(
                searchText.toLowerCase(),
              ),
        )
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF0B57D0),
        foregroundColor: Colors.white,

        title: const Text(
          "Districts",
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
           if (index == 2) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const AboutScreen()),
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

      body: Column(
        children: [

          Padding(
            padding:
                const EdgeInsets.all(16),

            child: TextField(
              controller:
                  searchController,

              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },

              decoration:
                  InputDecoration(
                hintText:
                    "Search district...",

                prefixIcon:
                    const Icon(
                  Icons.search,
                ),

                filled: true,

                fillColor:
                    Colors.grey.shade100,

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius
                          .circular(
                    12,
                  ),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount:
                  filteredDistricts.length,

              itemBuilder:
                  (context, index) {

                final district =
                    filteredDistricts[
                        index];

                return ListTile(

                  leading: Container(
                    width: 42,
                    height: 42,

                    decoration:
                        BoxDecoration(
                      color: Colors
                          .blue
                          .shade50,

                      borderRadius:
                          BorderRadius
                              .circular(
                        10,
                      ),
                    ),

                    child: const Icon(
                      Icons.location_city,
                      color:
                          Color(
                        0xFF0B57D0,
                      ),
                    ),
                  ),

                  title: Text(
                    district["name"],
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),

                  subtitle: Text(
                    "${district["stations"]} Stations",
                  ),

                  trailing: const Icon(
                    Icons
                        .arrow_forward_ios,
                    size: 16,
                  ),

                  onTap: () {

                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) =>
                            StationListScreen(
                          district:
                              district[
                                  "name"],
                        ),
                      ),
                    );

                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}