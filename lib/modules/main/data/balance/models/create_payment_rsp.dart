class CreatePaymentSheetResponse {
  final String paymentIntentSecret;
  final String paymentIntentID;
  final String ephemeralKey;
  final String customer;

  CreatePaymentSheetResponse({
    required this.paymentIntentSecret,
    required this.paymentIntentID,
    required this.ephemeralKey,
    required this.customer,
  });

  factory CreatePaymentSheetResponse.fromJson(Map<String, dynamic> json) {
    return CreatePaymentSheetResponse(
      paymentIntentSecret: json['paymentIntentSecret'],
      paymentIntentID: json['paymentIntentID'],
      ephemeralKey: json['ephemeralKey'],
      customer: json['customer'],
    );
  }
}
