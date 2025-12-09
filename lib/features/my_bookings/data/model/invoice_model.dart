class InvoiceModel {
  final String? totalPrice;
  final num? deposit;
  final num? remainingBalance;

  InvoiceModel({
    required this.totalPrice,
    required this.deposit,
    required this.remainingBalance,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      totalPrice: json['total_price'] ?? '',
      deposit: json['deposit'] ?? 0,
      remainingBalance: json['remaining balance'] ?? 0,
    );
  }

  factory InvoiceModel.empty() {
    return InvoiceModel(
      totalPrice: '',
      deposit: 0,
      remainingBalance: 0,
    );
  }
}
