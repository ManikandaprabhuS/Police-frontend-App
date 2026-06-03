import 'package:flutter/material.dart';
import 'package:police/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about_screen.dart';
import 'home_screen.dart';

class StationDetailsScreen extends StatefulWidget {
  final String stationId;

  const StationDetailsScreen({
    super.key,
    required this.stationId,
  });

  @override
  State<StationDetailsScreen> createState() =>
      _StationDetailsScreenState();
}

class _StationDetailsScreenState
    extends State<StationDetailsScreen> {
  Map<String, dynamic>? station;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadStationDetails();
  }

  Future<void> loadStationDetails() async {
    try {
      final data =
          await ApiService.getStationDetails(
        widget.stationId,
      );
       print("FULL STATION DATA:");
    print(data);

      setState(() {
        station = data;
        isLoading = false;
      });
    } catch (e) {
      print("STATION DETAILS ERROR: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> makePhoneCall(
    String phone,
  ) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: phone,
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Widget contactCard({
    required String title,
    required String officerName,
    required String phone,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
              color: Colors.blue,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            officerName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(phone),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,

            child: ElevatedButton.icon(
              onPressed:
                  phone == "Not Available"
                      ? null
                      : () =>
                          makePhoneCall(
                            phone,
                          ),

              icon:
                  const Icon(Icons.call),

              label:
                  const Text("Call"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF0B57D0),
        foregroundColor:
            Colors.white,

        title: Text(
          station?["stationName"] ??
              "Station Details",
        ),
      ),

      bottomNavigationBar:
          BottomNavigationBar(
        currentIndex: 0,

        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const HomeScreen(),
              ),
              (route) => false,
            );
          }

          if (index == 2) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const AboutScreen(),
              ),
              (route) => false,
            );
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
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

      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : station == null
              ? const Center(
                  child: Text(
                    "Unable to load station details",
                  ),
                )
              : _buildContent(),
    );
  }

  Widget _buildContent() {
    final primaryOfficer =
        station!["primaryOfficerName"] ??
            "Not Available";

    final primaryPhone =
        station!["primaryOfficerPhone"] ??
            "Not Available";

    final nightOfficer =
        (station!["nightOfficerName"] ==
                    null ||
                station![
                        "nightOfficerName"]
                    .toString()
                    .isEmpty)
            ? "Not Assigned"
            : station![
                "nightOfficerName"];

    final nightPhone =
        (station!["nightOfficerPhone"] ==
                    null ||
                station![
                        "nightOfficerPhone"]
                    .toString()
                    .isEmpty)
            ? "Not Available"
            : station![
                "nightOfficerPhone"];

    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 180,

              decoration:
                  BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius
                        .circular(
                  12,
                ),
              ),

              child: Center(
                child: Image.asset(
                  'assets/images/tn_police_logo.png',
                  height: 120,
                ),
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            contactCard(
              title:
                  "Primary Contact",
              officerName:
                  primaryOfficer,
              phone:
                  primaryPhone,
            ),

            const SizedBox(
              height: 12,
            ),

            contactCard(
              title:
                  "Night Shift Contact",
              officerName:
                  nightOfficer,
              phone:
                  nightPhone,
            ),

            const SizedBox(
              height: 12,
            ),

            Container(
              width:
                  double.infinity,

              padding:
                  const EdgeInsets
                      .all(16),

              decoration:
                  BoxDecoration(
                color:
                    Colors.white,

                borderRadius:
                    BorderRadius
                        .circular(
                  12,
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons
                            .location_on,
                        color:
                            Colors
                                .blue,
                      ),

                      SizedBox(
                        width: 8,
                      ),

                      Text(
                        "Address",
                        style:
                            TextStyle(
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    station![
                            "address"] ??
                        "Address Not Available",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
