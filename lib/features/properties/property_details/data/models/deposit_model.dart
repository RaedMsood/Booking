class DepositModel {
  final String depositRatio;
  final String policy;

  DepositModel({required this.depositRatio, required this.policy});

  factory DepositModel.fromJson(Map<String, dynamic> json) {
    return DepositModel(
      depositRatio: json['deposit_ratio'] ?? '',
      policy: json['policy'] ?? '',
    );
  }

  factory DepositModel.empty() => DepositModel(
        depositRatio: '',
        policy: '',
      );
}
