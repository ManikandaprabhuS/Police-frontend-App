class DistrictModel {
  final String id;
  final String districtName;

  DistrictModel({
    required this.id,
    required this.districtName,
  });

  factory DistrictModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DistrictModel(
      id: json['_id'] ?? '',
      districtName: json['districtName'] ?? '',
    );
  }
}