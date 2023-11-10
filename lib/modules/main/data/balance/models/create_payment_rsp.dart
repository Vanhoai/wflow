class CreatePaymentSheetResponse {
  final String paymentIntentSecret;
  final String paymentIntentID;
  final String ephemeralKey;
  final String customer;
  final String publishableKey;

  CreatePaymentSheetResponse({
    required this.paymentIntentSecret,
    required this.paymentIntentID,
    required this.ephemeralKey,
    required this.customer,
    required this.publishableKey,
  });

  factory CreatePaymentSheetResponse.fromJson(Map<String, dynamic> json) {
    return CreatePaymentSheetResponse(
      paymentIntentSecret: json['paymentIntentSecret'],
      paymentIntentID: json['paymentIntentID'],
      ephemeralKey: json['ephemeralKey'],
      customer: json['customer'],
      publishableKey: json['publishableKey'],
    );
  }
}
