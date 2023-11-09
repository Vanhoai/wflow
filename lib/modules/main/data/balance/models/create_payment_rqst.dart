class CreatePaymentSheetRequest {
  final String customer;
  final num amount;

  CreatePaymentSheetRequest({
    required this.customer,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'customer': customer,
      'amount': amount,
    };
  }
}
