import 'property_data_model.dart';

class PropertyPaginationModel {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final List<PropertyDataModel> data;

  PropertyPaginationModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.data,
  });

  factory PropertyPaginationModel.fromJson(Map<String, dynamic> json) {
    return PropertyPaginationModel(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 5,
      total: json['total'] ?? 0,
      data: PropertyDataModel.fromJsonList(json['data'] ?? []),
    );
  }

  PropertyPaginationModel copyWith({
    int? currentPage,
    int? lastPage,
    int? perPage,
    int? total,
    List<PropertyDataModel>? data,
  }) {
    return PropertyPaginationModel(
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      total: total ?? this.total,
      data: data ?? this.data,
    );
  }

  factory PropertyPaginationModel.empty() {
    return PropertyPaginationModel(
      currentPage: 0,
      lastPage: 0,
      perPage: 0,
      total: 0,
      data: [],
    );
  }
}
