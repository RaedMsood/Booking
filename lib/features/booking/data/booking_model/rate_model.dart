class RateModel {
  final int? id;
  final String? nameOfRate;
   dynamic numberOfRate;

  RateModel({this.id, this.nameOfRate, this.numberOfRate});

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      id: json['id'],
      nameOfRate: json['name'],
      numberOfRate: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'score':numberOfRate
    };
  }

  static List<RateModel> fromJsonList(List json) {
    return json.map((e) => RateModel.fromJson(e)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<RateModel> list) {
    return list.map((e) => e.toJson()).toList();
  }
}