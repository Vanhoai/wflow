class CreatePaymentSheetResponse {
  final String paymentIntent;
  final String ephemeralKey;
  final String customer;
  final String publishableKey;

  CreatePaymentSheetResponse({
    required this.paymentIntent,
    required this.ephemeralKey,
    required this.customer,
    required this.publishableKey,
  });

  factory CreatePaymentSheetResponse.fromJson(Map<String, dynamic> json) {
    return CreatePaymentSheetResponse(
      paymentIntent: json['paymentIntent'],
      ephemeralKey: json['ephemeralKey'],
      customer: json['customer'],
      publishableKey: json['publishableKey'],
    );
  }
}
