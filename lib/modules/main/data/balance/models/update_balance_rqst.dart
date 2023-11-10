class UpdateBalanceRequest {
  final num amount;
  final num balanceID;
  final String paymentIntentID;

  UpdateBalanceRequest({
    required this.amount,
    required this.balanceID,
    required this.paymentIntentID,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'balanceID': balanceID,
      'paymentIntentID': paymentIntentID,
    };
  }
}
