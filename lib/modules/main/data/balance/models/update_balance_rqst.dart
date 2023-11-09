class UpdateBalanceRequest {
  final num amount;
  final num balanceID;

  UpdateBalanceRequest({
    required this.amount,
    required this.balanceID,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'balanceID': balanceID,
    };
  }
}
