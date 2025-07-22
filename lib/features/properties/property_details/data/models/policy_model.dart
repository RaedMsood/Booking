class PolicyModel {
  final int id;
  final String name;
  final String description;
  final String all;

  PolicyModel({
    required this.id,
    required this.name,
    required this.description,
    required this.all,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(
      id: json['id'] as int,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      all: json['all'] ?? '',
    );
  }

  static List<PolicyModel> fromJsonList(List json) {
    return json.map((e) => PolicyModel.fromJson(e)).toList();
  }

  factory PolicyModel.empty() => PolicyModel(
        id: 0,
        name: '',
        description: '',
        all: '',
      );
}
