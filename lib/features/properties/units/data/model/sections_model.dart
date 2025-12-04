import '../../../../../core/state/pagination_data/paginated_model.dart';
import 'units_model.dart';

class UnitsInPropertySectionsModel {
  final List<SectionsModel> sections;
  final PaginationModel<UnitsModel> units;

  UnitsInPropertySectionsModel({
    required this.sections,
    required this.units,
  });

  factory UnitsInPropertySectionsModel.fromJson(Map<String, dynamic> json) {
    return UnitsInPropertySectionsModel(
      sections: SectionsModel.fromJsonList(json['sections'] ?? []),
      units: PaginationModel<UnitsModel>.fromJson(
        json['unit'],
            (prop) {
          return UnitsModel.fromJson(prop);
        },
      ),
    );
  }

  static List<UnitsInPropertySectionsModel> fromJsonList(List json) {
    return json.map((e) => UnitsInPropertySectionsModel.fromJson(e)).toList();
  }

  UnitsInPropertySectionsModel copyWith({
    List<SectionsModel>? sections,
    PaginationModel<UnitsModel>? units,
  }) {
    return UnitsInPropertySectionsModel(
      sections: sections ?? this.sections,
      units: units ?? this.units,
    );
  }
  factory UnitsInPropertySectionsModel.empty() => UnitsInPropertySectionsModel(
    sections: [],
    units: PaginationModel.empty(),
  );
}

class SectionsModel {
  final int id;
  final String name;
  final List<UnitsModel>? units;

  SectionsModel({
    required this.id,
    required this.name,
    this.units,
  });

  factory SectionsModel.fromJson(Map<String, dynamic> json) {
    return SectionsModel(
      id: json['id'] as int,
      name: json['name'] ?? '',
      units: UnitsModel.fromJsonList(json['units'] ?? []),
    );
  }

  static List<SectionsModel> fromJsonList(List json) {
    return json.map((e) => SectionsModel.fromJson(e)).toList();
  }

  factory SectionsModel.empty() => SectionsModel(
    id: 0,
    name: '',
  );
}
