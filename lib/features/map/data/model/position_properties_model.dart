class PositionPropertiesModel {
  final int id;
  final String lat;
  final String lng;

  PositionPropertiesModel(
      {required this.id, required this.lng, required this.lat});

  factory PositionPropertiesModel.fromJson(Map<String, dynamic> json) {
    return PositionPropertiesModel(
      id: json['property_id'],
      lat: json['latitude']??'',
      lng: json['longitude']??'',
    );
  }
  static List<PositionPropertiesModel> fromJsonList(List json) {
    return json.map((e) => PositionPropertiesModel.fromJson(e)).toList();
  }
}
