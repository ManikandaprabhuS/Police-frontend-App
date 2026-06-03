import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'station_list_screen.dart';
import 'about_screen.dart';
import '../services/api_service.dart';

class DistrictListScreen extends StatefulWidget {
  const DistrictListScreen({super.key});

  @override
  State<DistrictListScreen> createState() => _DistrictListScreenState();
}

class _DistrictListScreenState extends State<DistrictListScreen> {
  final TextEditingController searchController = TextEditingController();

  List<dynamic> districts = [];
  bool isLoading = true;

  String searchText = "";

  @override
  void initState() {
    super.initState();
    loadDistricts();
  }

  Future<void> loadDistricts() async {
    try {
      print("Calling District API...");

      final data = await ApiService.getDistricts();

      print("API Response:");
      print(data);

      setState(() {
        districts = data;
        isLoading = false;
      });

      print("District Count: ${districts.length}");
    } catch (e) {
      print("API ERROR: $e");

      setState(() {
        isLoading = false;
      });
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No internet connection. Please check your network."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredDistricts = districts
        .where(
          (district) => district["districtName"]
              .toString()
              .toLowerCase()
              .contains(searchText.toLowerCase()),
        )
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B57D0),
        foregroundColor: Colors.white,
        title: const Text("Districts"),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,

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
            padding: const EdgeInsets.all(16),

            child: TextField(
              controller: searchController,

              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },

              decoration: InputDecoration(
                hintText: "Search district...",
                prefixIcon: const Icon(Icons.search),

                filled: true,
                fillColor: Colors.grey.shade100,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : districts.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wifi_off, size: 60, color: Colors.grey),
                        SizedBox(height: 10),
                        Text(
                          "Unable to load districts",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Check your internet connection",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredDistricts.length,
                    itemBuilder: (context, index) {
                      final district = filteredDistricts[index];

                      return ListTile(
                        leading: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.location_city,
                            color: Color(0xFF0B57D0),
                          ),
                        ),
                        title: Text(
                          district["districtName"],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text("Police Stations"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
