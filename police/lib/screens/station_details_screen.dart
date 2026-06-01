import 'package:flutter/material.dart';

class StationDetailsScreen extends StatelessWidget {
  final String stationName;

  const StationDetailsScreen({
    super.key,
    required this.stationName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B57D0),
        foregroundColor: Colors.white,
        elevation: 0,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              stationName,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const Text(
              "Last Updated: Today",
              style: TextStyle(
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [

              Container(
                width: double.infinity,
                height: 180,

                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(12),

                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/tn_police_logo.png',
                    ),
                    fit: BoxFit.contain,
                  ),
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 16),

              _contactCard(
                title: "Night Shift Contact",
                officerName: "Ravi Kumar",
                phone: "9876543210",
              ),

              const SizedBox(height: 12),

              _contactCard(
                title: "Primary Contact",
                officerName: "Suresh Reddy",
                phone: "9123456780",
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Row(
                      children: [

                        Icon(
                          Icons.location_on,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 8),

                        Text(
                          "Address",
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Peelamedu, Coimbatore,\nTamil Nadu - 641004",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton.icon(
                  onPressed: () {},

                  icon: const Icon(
                    Icons.navigation,
                    color: Colors.white,
                  ),

                  label: const Text(
                    "Get Directions",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF0B57D0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactCard({
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
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            officerName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(phone),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,

            child: ElevatedButton.icon(
              onPressed: () {},

              icon: const Icon(Icons.call),

              label: const Text("Call"),
            ),
          ),
        ],
      ),
    );
  }
}