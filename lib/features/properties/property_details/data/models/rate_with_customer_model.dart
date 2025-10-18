import '../../../../my_bookings/data/model/rate_model.dart';

class RateWithCustomerModel {
  final int? id;
  final List<RateModel>? allScore;
  final String? customerName;
  final String? timeScore;
  final dynamic avg;

  RateWithCustomerModel({this.id, this.allScore, this.customerName,this.avg,required this.timeScore});

  factory RateWithCustomerModel.fromJson(Map<String, dynamic> json) {
    return RateWithCustomerModel(
      id: json['id'],
      allScore:RateModel.fromJsonList(json['criteria']) ,
      customerName: json['user'],
      timeScore: json['time'],
      avg: json['average']
    );
  }



  static List<RateWithCustomerModel> fromJsonList(List json) {
    return json.map((e) => RateWithCustomerModel.fromJson(e)).toList();
  }

}