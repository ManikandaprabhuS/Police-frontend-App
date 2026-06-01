import 'package:flutter/material.dart';
import 'package:police/screens/about_screen.dart';
import 'home_screen.dart';
import 'station_details_screen.dart';

class StationListScreen extends StatefulWidget {
  final String district;

  const StationListScreen({
    super.key,
    required this.district,
  });

  @override
  State<StationListScreen> createState() =>
      _StationListScreenState();
}

class _StationListScreenState
    extends State<StationListScreen> {

  final TextEditingController searchController =
      TextEditingController();

  String searchText = "";

  final List<String> stations = [
    "Peelamedu Police Station",
    "Saravanampatti Police Station",
    "Airport Police Station",
    "B-7 Ramanathapuram Police Station",
    "Race Course Police Station",
    "Ganapathy Police Station",
  ];

  @override
  Widget build(BuildContext context) {

    final filteredStations = stations
        .where(
          (station) => station
              .toLowerCase()
              .contains(
                searchText.toLowerCase(),
              ),
        )
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0B57D0),
        foregroundColor: Colors.white,

        title: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              "${widget.district} District",
              style: const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            Text(
              "${filteredStations.length} Stations",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),

        actions: [

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.star_border,
            ),
          ),
        ],
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

            child: Row(
              children: [

                Expanded(
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
                          "Search station...",

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
                            BorderRadius.circular(
                                12),

                        borderSide:
                            BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Container(
                  height: 50,
                  width: 50,

                  decoration:
                      BoxDecoration(
                    color:
                        Colors.grey.shade100,

                    borderRadius:
                        BorderRadius.circular(
                            12),
                  ),

                  child: const Icon(
                    Icons.filter_alt_outlined,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              itemCount:
                  filteredStations.length,

              itemBuilder:
                  (context, index) {

                return StationCard(
                  stationName:
                      filteredStations[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StationCard extends StatelessWidget {
  final String stationName;

  const StationCard({
    super.key,
    required this.stationName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                StationDetailsScreen(
              stationName: stationName,
            ),
          ),
        );

      },

      child: Card(
        elevation: 1,

        margin:
            const EdgeInsets.only(bottom: 12),

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(14),
        ),

        child: ListTile(
          contentPadding:
              const EdgeInsets.all(12),

          leading: Container(
            height: 45,
            width: 45,

            decoration:
                BoxDecoration(
              color:
                  Colors.blue.shade50,

              borderRadius:
                  BorderRadius.circular(
                      10),
            ),

            child: const Icon(
              Icons.local_police,
              color:
                  Color(0xFF0B57D0),
            ),
          ),

          title: Text(
            stationName,
            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          subtitle: const Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              SizedBox(height: 5),

              Text("Tamil Nadu"),

              SizedBox(height: 3),

              Text(
                "● Available",
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ],
          ),

          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
        ),
      ),
    );
  }
}