import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class ApiService {
  static Future<List<dynamic>> getDistricts() async {
    final response = await http.get(
      Uri.parse("${AppConfig.apiBaseUrl}/districts"),
    );

    print("Status Code: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["districts"];
    }

    throw Exception("Failed to load districts");
  }

  static Future<List<dynamic>> getStations() async {
    final response = await http.get(
      Uri.parse("${AppConfig.apiBaseUrl}/stations"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["stations"];
    }

    throw Exception("Failed to load stations");
  }

  static Future<Map<String, dynamic>> getStationDetails(
    String stationId,
  ) async {
    final response = await http.get(
      Uri.parse("${AppConfig.apiBaseUrl}/stations/$stationId"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["station"];
    }

    throw Exception("Failed to load station details");
  }

  static Future<List<dynamic>> getStationsByDistrict(String districtId) async {
    final response = await http.get(
      Uri.parse("${AppConfig.apiBaseUrl}/stations/district/$districtId"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data["stations"];
    }

    throw Exception("Failed to load stations");
  }
}
